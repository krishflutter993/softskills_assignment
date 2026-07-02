---
name: KEEPER
colors:
  surface: '#12131b'
  surface-dim: '#12131b'
  surface-bright: '#383941'
  surface-container-lowest: '#0c0e15'
  surface-container-low: '#1a1b23'
  surface-container: '#1e1f27'
  surface-container-high: '#282932'
  surface-container-highest: '#33343d'
  on-surface: '#e2e1ed'
  on-surface-variant: '#c4c5d7'
  inverse-surface: '#e2e1ed'
  inverse-on-surface: '#2f3038'
  outline: '#8e90a0'
  outline-variant: '#444654'
  surface-tint: '#b8c4ff'
  primary: '#b8c4ff'
  on-primary: '#002585'
  primary-container: '#6c88ff'
  on-primary-container: '#001f75'
  inverse-primary: '#2c51d4'
  secondary: '#d2bbff'
  on-secondary: '#3e008e'
  secondary-container: '#5a1eba'
  on-secondary-container: '#c6aaff'
  tertiary: '#ffb781'
  on-tertiary: '#4e2500'
  tertiary-container: '#db7612'
  on-tertiary-container: '#452000'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#dde1ff'
  primary-fixed-dim: '#b8c4ff'
  on-primary-fixed: '#001454'
  on-primary-fixed-variant: '#0037ba'
  secondary-fixed: '#eaddff'
  secondary-fixed-dim: '#d2bbff'
  on-secondary-fixed: '#25005a'
  on-secondary-fixed-variant: '#581ab8'
  tertiary-fixed: '#ffdcc5'
  tertiary-fixed-dim: '#ffb781'
  on-tertiary-fixed: '#301400'
  on-tertiary-fixed-variant: '#703800'
  background: '#12131b'
  on-background: '#e2e1ed'
  surface-variant: '#33343d'
typography:
  headline-xl:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Geist
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.05em
  code-sm:
    fontFamily: Geist
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  gutter: 16px
  margin-mobile: 20px
  margin-desktop: 40px
---

## Brand & Style
The design system for this product is centered on the concept of "Digital Fortification." It blends the sleek, reductive elegance of high-end consumer electronics with the sophisticated visual cues of modern cybersecurity. The brand personality is authoritative yet approachable, evoking a sense of impenetrable security through clarity and precision.

The aesthetic utilizes a **Cyber-Minimalist** style—a hybrid of Apple-inspired whitespace (or "darkspace") and futuristic glassmorphism. It leverages deep atmospheric depths, translucent materials, and soft, inner-glow neomorphism to simulate a high-tech physical interface. The emotional response should be one of absolute trust, calm, and effortless control over one's digital identity.

## Colors
The palette is rooted in a "Deep Midnight" spectrum to reinforce the theme of security and focus. 

- **Primary (Electric Blue):** Used for primary actions, active states, and critical security indicators. It represents the "energy" of the system.
- **Secondary (Soft Purple):** Used for accents, secondary brand elements, and to create depth within gradients.
- **Background & Surfaces:** The deep navy foundations ensure high contrast for text while allowing glassmorphic overlays to "pop" without causing eye strain.
- **Semantic Colors:** Success, Warning, and Error colors are saturated to remain highly visible against the dark UI, ensuring critical status updates are never missed.

## Typography
This design system uses **Inter** for its exceptional legibility and systematic feel, providing a clean, professional foundation. For technical data and labels, **Geist** is introduced to provide a "developer-tool" precision that aligns with the cybersecurity theme.

Headlines should be bold and tightly tracked to feel impactful. Body copy remains airy with generous line heights to ensure readability in complex data environments. Label styles use uppercase tracking to differentiate metadata from primary content.

## Layout & Spacing
The layout follows a fluid-first philosophy with a 4px baseline grid. On mobile devices, a 20px side margin is maintained to provide breathing room, while internal card padding defaults to 24px (lg) to emphasize a premium feel.

- **Stacking:** Use "md" (16px) spacing for related elements within a card and "xl" (32px) for spacing between major sections.
- **Grid:** A 4-column grid is used for mobile portrait, expanding to a 12-column grid for tablets/desktop.
- **Safe Areas:** Strict adherence to bottom-edge safe areas is required for the floating bottom navigation bar.

## Elevation & Depth
Depth is created through a combination of **Glassmorphism** and **Soft Neumorphism**. 

1.  **The Base Layer:** The Deep Midnight background (#08122F) acts as the infinite void.
2.  **The Container Layer:** Cards use a slightly lighter navy (#132042) with a subtle 1px inner border (opacity 10% white) to define edges.
3.  **The Glass Layer:** Overlays (modals, bottom nav) use a backdrop blur (20px) with a semi-transparent fill.
4.  **Shadows:** Use large, ultra-soft shadows with a 0% to 15% opacity primary color tint to create a "glow" rather than a dark shadow. This simulates the light emitted from high-tech displays.

## Shapes
The shape language is ultra-rounded, conveying a "soft-tech" feel that balances the coldness of the navy/blue palette. 

- **Primary Containers:** 24px to 32px corner radius.
- **Buttons:** Fully pill-shaped (rounded-xl) for maximum touch affordance.
- **Input Fields:** 16px radius to maintain structural integrity while remaining soft.
- **Interactive States:** Use a subtle "pressed" effect (inner shadow) to simulate physical depth when a user interacts with a button or card.

## Components

### Buttons
- **Primary:** Gradient fill (Primary to Secondary), pill-shaped, with a subtle drop-glow. Text is white, bold.
- **Ghost:** 1px border using Text Secondary color, no fill.

### Glass Cards
- Used for password entries and vault items. Features a 1px "highlight" top border and 20px backdrop blur.
- **Active State:** A subtle Primary color outer glow.

### Input Fields
- Background uses the Surface color (#132042) with a 16px radius.
- **Focus State:** Border changes to Primary Blue with a 4px soft outer glow. Label floats upward using the "label-md" type style.

### Bottom Navigation
- A floating glass bar detached from the screen bottom.
- **Active Indicator:** A small, glowing dot or a soft pill-shaped highlight behind the active icon using the Primary color at 20% opacity.

### Security Indicators
- **Strength Meters:** Use thick, rounded segments with gradients from Error (Red) to Success (Green).
- **Biometric Prompt:** A large, centered glassmorphic circle with an animated Primary Blue outer ring.