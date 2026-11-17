---
name: design-audit-from-references
description: Audit an existing UI against reference sites the user admires, by extracting transferable mechanics rather than copying surface style. Use when someone says an interface "looks AI-generated," "feels templated," or "should feel more like <site>."
---

# Design Audit From References

Someone hands you two or three sites they like and asks why theirs doesn't feel the same. The naive move is to copy what the references look like. That produces a worse version of someone else's site.

The useful move is to find the **mechanics** the references share, measure the target against them, and fix root causes. This skill is that procedure, plus the reasoning that makes it repeatable.

## The core principle

> References are evidence, not mood boards.

A reference is useful for exactly one thing: it is a working example of a decision someone made deliberately. Your job is to recover the decision — not the pixels.

"Make it look like Lightspark" fails. "Lightspark separates its stat columns with hairline rules at ~6% opacity instead of filled cards, so the eye follows content instead of counting boxes" succeeds, because that sentence is directly implementable and survives translation to a different product.

**Test for whether you've extracted a mechanic:** can you write it as a CSS rule or a layout constraint? If your note is an adjective — clean, minimal, premium, elegant — you haven't finished looking.

## Procedure

### 1. Look at the references visually

Open them in a browser and screenshot. Do not fetch them as text. You are auditing *visual* decisions; markdown extraction throws away everything you need — spacing, type ratios, colour counts, how much emptiness a container carries.

### 2. Scroll past the hero

The hero is the least transferable part of any site. It is bespoke, often illustration-driven, and has no equivalent in a dashboard. Everyone screenshots the hero; almost nothing in it transfers.

Go to the **content sections** — stat rows, feature blocks, lists, tables, empty states. That is where a design system reveals itself, because those parts had to be systematized to exist at all.

### 3. Extract mechanics, and only keep what repeats

Write down specifics: exact type sizes and their ratios, how containers separate, how much internal emptiness exists, how many colours appear, how large the buttons are, where the accent shows up and how often.

Then **keep only what two or more references agree on.** One site's choice is a house style. Three sites independently agreeing is a principle, and principles are what survive being moved to a different product.

This is why three references beat one. With a single reference you copy. With three you are *forced* to abstract to what they share.

### 4. Notice what is absent

The strongest decisions in a refined interface are removals, and removals are invisible unless you look for them.

Lightspark's stat row has no card. Clay's feature sections have no internal borders. None of the three used dark chrome. Each absence is a decision someone made and you can make too.

Ask of every reference: *what would a default implementation have added here that this doesn't have?*

### 5. Count things in the target

This is the highest-value step and the one people skip.

Taste arguments are unfalsifiable until you count. "It looks AI-generated" is a vibe someone can disagree with. These are facts:

| Measure | How to get it |
| --- | --- |
| Distinct colour literals | `grep -oE "#[0-9a-fA-F]{3,6}" styles.css \| sort -u \| wc -l` |
| Distinct font sizes | `grep -oE "font-size: [0-9]+px" \| sort -u` |
| Distinct border radii | `grep -oE "border-radius: [0-9]+px" \| sort -u` |
| Hairline borders | `grep -cE "border(-top\|-bottom\|-left\|-right)?: 1px"` |
| Accent usages | `grep -c "var(--accent)"` |

A generated stylesheet will show something like 104 colours, 14 font sizes, 5 radii. A designed one shows 12 / 5 / 2. The gap *is* the finding, and it converts a matter of opinion into a matter of record.

Counting also tells you what "right" looks like. Fourteen font sizes feels fine until you learn good systems use five.

### 6. Diagnose causally, not symptomatically

A list of complaints is not an audit. Find the root cause that produces the symptoms.

Worked example: the target had 26 hairline borders and read as busy. The *cause* was that the page background and the card background differed by 2%. Surfaces that close together are invisible, so every one needs an outline to exist. Fix the surface relationship and 20 borders become unnecessary — treat the borders directly and you're sanding symptoms forever.

Always ask: **what single decision upstream produces this whole class of problem?**

### 7. Apply the "what is this screen for" test

Find the one number or statement the user opened the screen to get. Check whether it is the most prominent thing present.

In the worked example, the product's entire question was *does this truck get home on time*, and the answer — remaining margin — rendered at 14px, smaller than the sidebar navigation. That is not a style error; it is a hierarchy error, and no amount of palette work fixes it.

This test finds problems that reference-matching never will.

### 8. Separate design problems from data problems

Some of what looks wrong is the content, not the styling. A row of identical metrics looks bad because the numbers are identical, and no design choice fixes that.

Say so explicitly. Improving the design often makes a data problem *more* visible, which is a real and worth-flagging consequence.

### 9. Rank by impact and propose a token set first

Order findings by how much each one changes the product's ability to do its job. Lead with the root causes from step 6.

Propose the token layer before the component changes — the colour/type/radius/spacing vocabulary. Everything downstream either follows from it or contradicts it, and reviewers can evaluate a 14-line token block far faster than a 1,400-line stylesheet.

## Accent discipline

This deserves its own note because it recurs and because it is counter-intuitive.

**An accent used everywhere signals nothing.** If the brand colour is the sidebar fill, the button fill, the pill backgrounds, the headings, the timeline dots and the success state, then the success state has no way to stand out — it looks like furniture.

Reserve the accent for a short, explicit list, and write the list down in a comment:

```css
/* Default states stay neutral. The accent is reserved for the verdict,
   the primary action, active nav, and focus — nothing routine. */
```

**Routine states must be neutral.** If every row has "Projected capacity," that is the default condition, and defaults are grey. Accent the exception.

Then count your own work. A first pass at this put eleven accent elements on one screen; counting them forced the cut to two focal uses plus two near-invisible selection tints. **Apply step 5 to your own output, not just to the target.**

## How taste actually develops

Taste is not an innate preference. It is a trained ability to see *what decision was made*, and it develops through a small number of specific habits.

**Force the second sentence.** Everyone can say "I like this." The skill lives entirely in the next sentence: "I like this because the stat row has no card, the number sits at 55% of a 390px column, and the emptiness above it is deliberate." The gap between sentence one and sentence two is the whole discipline. Write sentence two every time, even when it's hard, especially when it's hard.

**Steal mechanics, not looks.** Copying appearance gives you a derivative. Copying a mechanic gives you a tool you can apply to problems the original never faced.

**Look at the boring parts.** Heroes are seductive and untransferable. Table rows, empty states, disabled buttons, error messages, the third item in a list — refinement shows up there because those parts can only be good if the system is good.

**Count, until you stop needing to.** Counting is training wheels for proportion. Do it explicitly until you develop a feel for how many greys a stylesheet should have, and then you'll notice the fifth redundant grey on sight.

**Name the anti-pattern.** Once you can say *"dingbat glyphs standing in for icons"* or *"marketing headline in an operational tool"* or *"state encoded three ways in one row,"* you stop shipping it. Unnamed mistakes recur; named ones don't. Keep the names.

**Notice absence.** Train yourself to ask what a default implementation would have added. Most refinement is subtraction, and subtraction is invisible until you deliberately look for it.

**Let the medium set the bar.** The same interface has different requirements as a marketing page versus a tool used forty times a day. 8px type is a defensible choice in a dense data grid and indefensible on a screen shown to an executive across a conference table. Taste is contextual or it is just preference.

**Revisit with fresh eyes.** You will see on the next day what you could not see while making it. Build the pause into the process rather than trusting that you'll catch it live.

## Failure modes

| Mistake | Why it fails |
| --- | --- |
| Copying the hero | Bespoke and untransferable; the system lives in the content sections |
| Adopting the reference's brand colour | Their blue carries their meaning, not yours. Ask what the accent should be |
| Fetching references as text | Throws away spacing, ratios, colour counts — everything being audited |
| Listing symptoms | 26 borders is a symptom; a 2% surface difference is the cause |
| Restyling before tokenizing | You'll make 104 new arbitrary decisions instead of 14 deliberate ones |
| Skipping the count | Leaves the audit arguable and gives you no measure of done |
| Changing text or classes the tests pin | Check selectors and assertions first, update in lockstep |
| Shipping without looking | Render it and *look*. Screenshots catch what diffs cannot |

## Verify by looking

A design change is not verified by a passing test suite. Tests confirm you didn't break behaviour; they say nothing about whether the result is good.

Render the actual screens, screenshot them, and examine them. In the worked example this caught a wrapped button label, an untruncated email, a selected row that was nearly invisible, and a status pill that vanished against its own selection background — none of which any test could have reported.

Then re-run the counts from step 5 on your own output and confirm the numbers moved.
