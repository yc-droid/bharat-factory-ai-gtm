# Bharat Factory AI — GTM Launch Repo

> **Pilot launch:** 2026-04-22, 9am IST
> **Scope:** 10 SDRs · 1-week pilot · 6 hot geos · target 700–1,000 workers closed
> **Review by:** @abhishek @varun

---

## Read order

1. [`handoff-abhishek/README.md`](./handoff-abhishek/README.md) — the one-pager for anyone loading this in a fresh context
2. [`handoff-abhishek/00-full-context.md`](./handoff-abhishek/00-full-context.md) — the single source of truth on commercials, ICP, positioning, stealth rules
3. [`handoff-abhishek/transcripts/`](./handoff-abhishek/transcripts) — Varun's verbatim pitch + unit economics + 2 testimonials + efficiency report walkthrough

## GTM artefacts (for review + approval)

| Doc | What it is | Review for |
|---|---|---|
| [`icp-and-qualification.md`](./icp-and-qualification.md) | Ideal Customer Profile + A/B/C/D qualification tiers + 4 disco questions | Is the ICP cut right? |
| [`sdr-cold-call-script.md`](./sdr-cold-call-script.md) | Full SDR script with Make-in-India framing, 4 gatekeeper openers, 3 DM opener variants, pitch, 12 objection handlers, referral ask | Does the framing protect stealth? Are objections complete? |
| [`whatsapp-templates.md`](./whatsapp-templates.md) | 10 WhatsApp templates covering full lead journey (cold → demo → NDA → pilot → payout → referral) | Tone right? Any legal flags? |
| [`lead-journey.md`](./lead-journey.md) | 10-stage lead map with owners, SLAs, exit criteria, conversion benchmarks | Are SLAs realistic given hardware shipping? |
| [`ad-targeting-spec.md`](./ad-targeting-spec.md) | Meta $350 + Google $250 split, 4 Meta ad sets, creative selection, conversion stack, kill thresholds | Geo/industry mix right? Budget split OK? |
| [`referral-program.md`](./referral-program.md) | ₹25k/factory referral · SDR split (₹15k/₹5k/₹2k/₹3k) · anti-fraud · launch steps | Payout split fair? TDS handling confirmed? |

## Public-facing

- **Landing page (EN):** https://bharat-factory-ai.salesup.workers.dev
- **Landing page (Hindi):** https://bharat-factory-ai.salesup.workers.dev/hi
- LP source: [`bharat-factory-lp/`](./bharat-factory-lp)

## Ad creatives

- [`creatives/`](./creatives) — 12 original ad visuals (fal.ai-generated, Indian factory context)
- [`creatives-mii/`](./creatives-mii) — same 12 creatives with **Make-in-India** tricolor badge overlay (1200×1200 square-HD, Meta-ready)

---

## Open approvals we need — before 9am IST

| # | Who | What | Why blocking |
|---|---|---|---|
| 1 | **Varun** | Green-light on the Indian brand logos displayed on LP trust bar (Tata Steel, MRF, Dabur, Mahindra, JSW, L&T, Aditya Birla) | Stealth risk if any isn't actually onboard. |
| 2 | **Varun** | Real numbers for impact strip (currently: ₹109 Cr disbursed · ₹340 Cr productivity unlocked · 21 lakh hrs saved — last two are placeholders) | Misleading claim risk. |
| 3 | **Varun** | Contract/invoicing POC confirmed | Go-live blocker. |
| 4 | **Varun** | Hardware ship SLA (48 hrs after MOU) — confirm headset stock for ~25 concurrent deployments | Hits the 700-worker guarantee. |
| 5 | **Abhishek** | Real Bharat Factory AI WhatsApp + call number to replace placeholder `+91 99999 99999` everywhere | All CTAs broken without it. |
| 6 | **Abhishek** | CRM / dialer tool confirmed (assumption: fresh Google Sheet or Zoho) | Lead capture backend. |
| 7 | **Abhishek** | SDR compensation split for internal referral layer approved | Unblocks training tonight. |
| 8 | **Varun + Abhishek** | Review the Make-in-India / PLI / Atmanirbhar Bharat framing — confirm we're *aligned with*, not *claiming to be* a govt scheme | IT Act / compliance risk. |

---

## Not in this repo (on purpose)

- Calling data CSV (contains 1,500+ factory phone numbers — handled separately via direct share)
- Raw testimonial videos (hosted on the LP)
- Secrets / API keys / Slack tokens (not in scope)

---

**Built overnight (2026-04-21) by Yash + Miskat + Claude Code second-brain.**
