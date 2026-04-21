#!/bin/bash
# Generate 6 Build.ai ad creatives via fal.ai nano-banana (Gemini 2.5 Flash Image)
# Fast text-to-image. ~$0.04/img, ~5s each.

set -e
cd "$(dirname "$0")"

# Load env
set -a; source ~/claude-code/.env; set +a

if [ -z "$FAL_KEY" ]; then
  echo "ERROR: FAL_KEY not set"; exit 1
fi

# Creative prompts (English for fal.ai — Hindi text will be overlaid in post if needed)
declare -a PROMPTS=(
"Wide shot of an Indian factory floor with rows of blue-collar workers at assembly stations. Subtle golden coin/currency overlay effect floating above machines, representing hidden revenue. Professional photography, cinematic lighting, 1:1 square composition. Text at top: 'Your factory's hidden Rs 47 lakh a month'. Modern B2B ad aesthetic."
"Close-up portrait of smiling Indian factory worker wearing a small head-mounted GoPro camera, standing in manufacturing environment. Natural lighting, approachable, trustworthy. 1:1 square. Text overlay bottom: 'Same shift. Same work. Rs 3,500 extra every month.' Hindi subtitle smaller."
"Split screen side-by-side comparison. LEFT side: smartphone showing a generic gig-work app with small coins icon. RIGHT side: a factory payroll slip with larger amount highlighted. Clean corporate design, 1.91:1 banner format. Text across top: 'Not a side hustle. A payroll upgrade.'"
"Aerial view of Indian manufacturing hub with factories, marked with pin drop over Pune auto belt industrial area. Evening golden hour. 1:1 square. Text overlay: 'Pune auto-belt plants: April pilot cohort open.' Corporate B2B style."
"Split composition: humanoid robot silhouette on left, Indian factory worker on right, connected by a subtle line of code/data flow. Futuristic yet grounded aesthetic. 1200x628 landscape banner. Text: 'Train the robots. Get paid for it.' Modern AI tech company ad style."
"Indian staffing agency owner at desk reviewing a ledger/spreadsheet on laptop, thoughtful expression, office background with city view. Professional B2B. 1.91:1 LinkedIn banner. Text: '5,000 workers deployed = 5,000 monthly income streams.'"
)

declare -a FILENAMES=(
"01_factory_hidden_revenue.jpg"
"02_worker_extra_income.jpg"
"03_not_side_hustle.jpg"
"04_pune_cohort.jpg"
"05_train_robots.jpg"
"06_staffing_agency.jpg"
)

# Fal.ai model: nano-banana (Gemini 2.5 Flash Image) — text-to-image mode
# Queue endpoint async, then poll
gen_one() {
  local idx=$1
  local prompt="${PROMPTS[$idx]}"
  local fname="${FILENAMES[$idx]}"

  echo "[$((idx+1))/6] Submitting: $fname"
  # Submit to nano-banana (text-to-image via Gemini 2.5 Flash Image)
  local resp
  resp=$(curl -s -X POST "https://queue.fal.run/fal-ai/nano-banana" \
    -H "Authorization: Key $FAL_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"prompt\": $(jq -Rs . <<<"$prompt"), \"num_images\": 1, \"output_format\": \"jpeg\"}")
  local request_id
  request_id=$(echo "$resp" | jq -r '.request_id // empty')
  if [ -z "$request_id" ]; then
    echo "  FAIL: $resp"; return 1
  fi

  # Poll for completion
  for i in $(seq 1 30); do
    sleep 2
    local status
    status=$(curl -s "https://queue.fal.run/fal-ai/nano-banana/requests/$request_id/status" \
      -H "Authorization: Key $FAL_KEY" | jq -r '.status')
    if [ "$status" = "COMPLETED" ]; then
      local result
      result=$(curl -s "https://queue.fal.run/fal-ai/nano-banana/requests/$request_id" \
        -H "Authorization: Key $FAL_KEY")
      local url
      url=$(echo "$result" | jq -r '.images[0].url // .image.url // empty')
      if [ -n "$url" ]; then
        curl -s -o "$fname" "$url"
        echo "  DONE: $fname"
        return 0
      else
        echo "  FAIL no url: $result"; return 1
      fi
    fi
  done
  echo "  TIMEOUT on $fname"
}

# Run all 6 in parallel
for i in 0 1 2 3 4 5; do
  gen_one $i &
done
wait
echo ""
echo "=== All creatives generated ==="
ls -la *.jpg 2>/dev/null
