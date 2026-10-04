# Venture — Visual Design System Specification

## Visual Concept: "Cinematic Futuristic Startup Strategy"

Venture's visual language is tailored to make startup simulation feel high-stakes, immersive, and sleek. It avoids dry administrative spreadsheet design in favor of cyberpunk-infused glassmorphism, rich glow accents, animated gauges, and high-contrast typography.

---

## 1. Color Palette

### Dark Obsidian Theme (Primary Game Mode)
- **Background Core**: `#0B0E17` (Deep Space Dark)
- **Card Surface**: `#141824` (Dark Glass Surface with `opacity: 0.85`)
- **Card Border**: `#2A324B` (Subtle Metallic Border with `0.5px` width)

### Brand Accent & Status Colors
- **Electric Cyan (Primary)**: `#00F2FE` (Primary action buttons, active navigation, cash growth)
- **Neon Purple (Secondary)**: `#4FACFE` / `#7F00FF` (AI characters, innovation stats, valuation)
- **Emerald Green (Success)**: `#00E676` (Positive profit, revenue gain, successful deal)
- **Amber Gold (Warning)**: `#FFB300` (Low runway warning, employee stress, delay risk)
- **Crimson Red (Danger)**: `#FF3366` (Burn rate crisis, bankruptcy risk, product failure)

---

## 2. Typography System

Powered by Google Fonts (JetBrains Mono for Financial Numbers, Outfit / Inter for UI):

| Role | Font Family | Size | Weight | Color | Usage |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Display Large** | Outfit | 32px | Bold | `#FFFFFF` | Hero headers, Game Over |
| **Headline Medium** | Outfit | 22px | SemiBold | `#E2E8F0` | Screen titles, Card headers |
| **Body Large** | Inter | 16px | Regular | `#CBD5E1` | Dialogue, event text |
| **Body Small** | Inter | 12px | Regular | `#94A3B8` | Labels, timestamps |
| **Financial Monospace**| JetBrains Mono| 18px | Bold | `#00F2FE` | Cash, Valuation, Burn rate |

---

## 3. UI Primitives & Components

1. **GlassCard**:
   - Background: `Color(0x141824)` with subtle border gradient `Color(0x2A324B)` -> `Color(0x00F2FE)`.
   - BoxShadow: Ambient shadow with `blurRadius: 16`, `color: Color(0x3300F2FE)`.

2. **GlowingButton**:
   - Primary button with subtle cyan glow box shadow and press scale animation.

3. **MetricCard**:
   - Compact status card displaying a key metric (e.g., Cash $1.2M), trend indicator (+15%), animated counter ticker, and icon.

4. **ResponsiveContainer**:
   - Adaptive container supporting Mobile (single column), Tablet (dual pane split), and Desktop/Web (multi-pane grid).

---

## 4. Micro-Interactions & Animation Standards

- **Number Ticker**: Monospace numbers smoothly count up/down when values change.
- **Card Entrance**: Staggered fade and slide-up transition (`300ms easeOutCubic`).
- **Pulse Alert**: Pulsing red glow when runway is less than 3 months.
