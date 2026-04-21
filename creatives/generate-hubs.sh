#!/bin/bash
# Generate 6 geo-targeted creatives for different Indian manufacturing belts
set -e
cd "$(dirname "$0")"
set -a; source ~/claude-code/.env; set +a

declare -a PROMPTS=(
"Aerial view of Gurgaon Manesar industrial belt with Maruti-style auto assembly plants, wide shot during golden hour. Pin-drop overlay marking the belt. 1:1 square. Text overlay top: 'Gurgaon Manesar auto plants: April pilot cohort open.' Modern B2B ad aesthetic, Hindi subtitle smaller. Professional."
"Chennai Sriperumbudur electronics manufacturing zone, large factory buildings with Tamil Nadu landscape, sunny. Pin-drop overlay. 1:1 square. Text overlay top: 'Chennai electronics belt: turn shifts into extra income.' Tamil subtitle smaller. Clean B2B corporate ad style."
"Ahmedabad Sanand auto + textile industrial zone aerial, Gujarat landscape with factories, vibrant. Pin-drop overlay. 1:1 square. Text: 'Ahmedabad plants: 100 pilot slots open for April.' Gujarati subtitle smaller. Modern ad composition."
"Bengaluru electronics and aerospace manufacturing hub, modern factory buildings, Karnataka landscape, professional golden light. Pin-drop overlay. 1:1 square. Text top: 'Bengaluru manufacturing: monetize your existing workforce.' Kannada subtitle smaller."
"Coimbatore textile and pump manufacturing belt, Tamil Nadu industrial landscape with textile mills, warm lighting. Pin-drop overlay. 1:1 square. Text: 'Coimbatore textiles: ₹47 lakh hidden monthly margin.' Tamil subtitle smaller. B2B ad style."
"Surat textile and diamond industrial area, Gujarat, busy manufacturing district aerial view. Pin-drop overlay. 1:1 square. Text: 'Surat factories: extra income on every deployed worker.' Gujarati subtitle smaller. Clean corporate aesthetic."
)

declare -a FILENAMES=(
"07_gurgaon_manesar.jpg"
"08_chennai_sriperumbudur.jpg"
"09_ahmedabad_sanand.jpg"
"10_bengaluru.jpg"
"11_coimbatore.jpg"
"12_surat.jpg"
)

gen_one() {
  local idx=$1
  local prompt="${PROMPTS[$idx]}"
  local fname="${FILENAMES[$idx]}"
  echo "[$((idx+1))/6] Submitting: $fname"
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
        echo "  DONE: $fname"
        return 0
      fi
    fi
  done
  echo "  TIMEOUT on $fname"
}

for i in 0 1 2 3 4 5; do gen_one $i & done
wait
echo ""; echo "=== Hub creatives done ==="; ls -la 07_*.jpg 08_*.jpg 09_*.jpg 10_*.jpg 11_*.jpg 12_*.jpg 2>/dev/null
