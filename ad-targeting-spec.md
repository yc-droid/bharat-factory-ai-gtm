# Bharat Factory AI — Week 1 Ad Targeting Spec

**Launch:** 2026-04-22 09:00 IST | **Pilot:** 7 days | **Budget:** $600 (~₹50,000) | **Brand:** Bharat Factory AI (Build.ai never referenced)

## 1. Creative Selection (6 of 12)

| # | Creative | Theme | Ad Set |
|---|---|---|---|
| 01 | factory_hidden_revenue | Owner pain / $25k report hook | Meta – Owner/MD |
| 02 | worker_extra_income | ₹4L/month cash lever | Meta – Owner/MD + Works Mgr |
| 05 | train_robots | Robot subsidy / future-proof | Meta – Broad + Google Demand Gen |
| 07 | hubli_textile | Hubli geo + textile | Meta – Hubli/Coimbatore textile |
| 09 | ahmedabad_sanand | Sanand auto/electronics | Meta – Ahmedabad/Nashik auto |
| 10 | bengaluru | Bengaluru + Chennai multi-sector | Meta – BLR/Chennai |

**Deferred (Week 2 if signal):** 03, 04, 06, 08, 11, 12. Pune (04) parked — not in HOT geo list.

## 2. Meta (FB + IG) — $350

- **Objective:** Leads (Instant Form) + Website CTA to LP (split 70/30).
- **Placements:** FB Feed, IG Feed, IG Reels, FB Reels. Exclude Audience Network.
- **Bidding:** Lowest cost, no cap Day 1–3; switch to cost-cap at ₹250/lead Day 4+.
- **Lookalikes:** Seed from LP form submits + WhatsApp clicks on Day 5 (1% LAL India).

### Ad Sets

| Set | Geo | Creatives | Daily | Audience |
|---|---|---|---|---|
| A1 Textile Belt | Hubli, Coimbatore (+25km) | 07, 02 | $10 | Interests: Textile manufacturing, Garment industry, Apparel; Titles: MD, Plant Manager, Works Manager |
| A2 Auto/Electronics | Ahmedabad/Sanand, Chennai/Sriperumbudur, Nashik (+25km) | 09, 10, 01 | $15 | Interests: Automotive industry, Auto parts, Electronics manufacturing, EMS; Titles: MD, Plant Head, Operations Director |
| A3 BLR Multi-sector | Bengaluru (+30km) | 10, 05 | $10 | Interests: Manufacturing, Industrial engineering, FMCG, Factory automation; Titles: Founder, CEO, COO |
| A4 Broad India Test | All 6 HOT cities | 01, 05 | $15 | Broad 35–60, M, excl. students. Advantage+ audience ON |

Total Meta daily = **$50 × 7 = $350**.

## 3. Google — $250

- **Split:** Search $150 / Demand Gen $100. (PMax deferred — too little data for 1 week.)
- **Locations:** Hubli, Bengaluru, Chennai+Sriperumbudur, Coimbatore, Ahmedabad+Sanand, Nashik. Radius target (not "interest in").
- **Languages:** English, Hindi, Tamil, Kannada, Gujarati, Marathi.

### Search Keyword Clusters

| Cluster | Seeds | Match |
|---|---|---|
| Efficiency audit | "factory efficiency consultant", "manufacturing productivity audit", "plant efficiency report" | Phrase |
| Cost reduction | "reduce factory labor cost", "factory cost optimization India" | Phrase |
| AI/automation | "AI for manufacturing", "factory automation consultant", "robots for factory" | Phrase + Broad (smart bid) |
| Worker income | "increase worker retention factory", "worker incentive scheme" | Phrase |

**Negatives:** jobs, vacancy, salary, resume, course, training certificate, MBA, ppt, pdf, download, internship, franchise, dealer.

### Demand Gen
Creatives 05, 01, 10. Audience: Custom segment "factory owner, MD manufacturing, plant head" + in-market "Business services > Industrial".

### Extensions
Sitelinks: *Free $25k Audit* / *₹4L per 100 Workers* / *Robot Early Access* / *Talk on WhatsApp*. Callouts: *Zero Cost*, *Zero Risk*, *Pilot Cohort*. Call ext: client WhatsApp BSP number.

## 4. Conversion Tracking

| Event | Fire | Meta (CAPI) | Google |
|---|---|---|---|
| `LP_View` | Page load | ViewContent | page_view |
| `Video_50` | 50% VSL | ViewContent (custom) | video_progress |
| `WA_Click` | WhatsApp CTA | Contact | conversion (Primary) |
| `Form_Submit` | LP form | Lead (Primary) | generate_lead (Primary) |

Use GTM + Meta CAPI Gateway (or Cloudflare worker proxy). Dedup via event_id. Pass hashed email/phone from form to CAPI + Google Enhanced Conversions.

## 5. Daily Budget & Pacing

| Day | Meta | Google | Action |
|---|---|---|---|
| 1–2 | $50 | $35 | Learning; no edits. |
| 3 | $50 | $35 | Pause bottom 20% creatives by CTR. |
| 4 | $50 | $35 | Shift +20% to winning ad set. Turn on cost cap. |
| 5 | $50 | $35 | Build LAL from converters, add as A5. |
| 6–7 | $50 | $40 | Scale winners +30%. Kill losers. |

## 6. Kill Criteria

| Metric | Threshold (48h min spend $15) | Action |
|---|---|---|
| CTR (link) | <0.8% Meta / <2% Search | Pause creative |
| CPM | >₹400 Meta | Narrow audience / swap creative |
| CPL (form or WA) | >₹800 | Pause ad set |
| Frequency | >3.0 in 5 days | Refresh creative |
| Search Impr. Share Lost (Rank) | >40% | Raise bid 15% |

**Overall kill:** if Day 3 CPL > ₹1,200 across campaign, pause and rework LP/offer with Yash before continuing.
