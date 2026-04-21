#!/bin/bash
# Regenerate: replace Surat/Gurgaon with Hubli/Nashik (per Varun's geo intel)
# Plus replace #01 hero with accurate ₹42L/mo on 1000-worker factory framing
set -e
cd "$(dirname "$0")"
set -a; source ~/claude-code/.env; set +a

declare -a PROMPTS=(
"Wide shot of a LARGE Indian manufacturing factory floor with hundreds of blue-collar workers at assembly stations. Scale visible — many rows of workers. Subtle golden coin overlay effect hinting at hidden revenue. 1:1 square. Text at top: 'Your 1,000-worker factory. Rs 42 lakh extra, every month.' Subtle Hindi subtitle. Modern B2B ad, cinematic."
"Close-up portrait of smiling Indian factory worker wearing a small head-mounted GoPro camera, manufacturing environment background, natural lighting, trustworthy. 1:1 square. Text overlay bottom: 'Same shift. Same work. Rs 4,000 extra every month.' Hindi subtitle smaller."
"Aerial view of Hubli industrial textile belt in Karnataka — rows of textile mills, busy industrial area in warm afternoon light. Pin-drop overlay. 1:1 square. Text overlay top: 'Hubli textile belt: April pilot cohort open.' Kannada subtitle smaller. Modern B2B ad aesthetic."
"Aerial view of Nashik industrial area Maharashtra — auto and pharma manufacturing plants visible, scenic landscape. Pin-drop overlay. 1:1 square. Text overlay top: 'Nashik plants: turn shifts into monthly income.' Marathi subtitle smaller. Professional ad style."
)

declare -a FILENAMES=(
"01_factory_hidden_revenue.jpg"
"02_worker_extra_income.jpg"
"07_hubli_textile.jpg"
"12_nashik_auto_pharma.jpg"
)

gen_one() {
  local idx=$1
  local prompt="${PROMPTS[$idx]}"
  local fname="${FILENAMES[$idx]}"
  echo "[$((idx+1))/4] Submitting: $fname"
  local resp
  resp=$(curl -s -X POST "https://queue.fal.run/fal-ai/nano-banana" \
    -H "Authorization: Key $FAL_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"prompt\": $(jq -Rs . <<<"$prompt"), \"num_images\": 1, \"output_format\": \"jpeg\"}")
  local request_id
  request_id=$(echo "$resp" | jq -r '.request_id // empty')
  [ -z "$request_id" ] && { echo "  FAIL: $resp"; return 1; }
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
        # Also delete old files being replaced
        echo "  DONE: $fname"
        return 0
      fi
    fi
  done
  echo "  TIMEOUT on $fname"
}

for i in 0 1 2 3; do gen_one $i & done
wait
# Remove obsolete creatives
rm -f 07_gurgaon_manesar.jpg 12_surat.jpg
echo ""; echo "=== v2 regen done ==="
