# Signature: dev.tswicolly03

from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter


ROOT = Path(__file__).resolve().parents[1]
OUTPUT_DIR = ROOT / "assets" / "branding"
SIZE = 1024


def lerp(a: int, b: int, t: float) -> int:
    return int(a + (b - a) * t)


def blend(c1: tuple[int, int, int], c2: tuple[int, int, int], t: float) -> tuple[int, int, int]:
    return tuple(lerp(c1[i], c2[i], t) for i in range(3))


def gradient_background() -> Image.Image:
    image = Image.new("RGBA", (SIZE, SIZE))
    pixels = image.load()
    top = (227, 248, 243)
    bottom = (173, 222, 214)
    glow = (250, 240, 209)

    center_x = SIZE * 0.72
    center_y = SIZE * 0.24
    max_distance = (SIZE**2 + SIZE**2) ** 0.5

    for y in range(SIZE):
      vertical = y / (SIZE - 1)
      base = blend(top, bottom, vertical)
      for x in range(SIZE):
        distance = (((x - center_x) ** 2) + ((y - center_y) ** 2)) ** 0.5
        glow_mix = max(0.0, 1.0 - (distance / max_distance) * 1.6)
        glow_mix *= 0.32
        color = blend(base, glow, glow_mix)
        pixels[x, y] = (*color, 255)

    return image


def draw_symbol(target: Image.Image, page_fill: tuple[int, int, int, int]) -> None:
    draw = ImageDraw.Draw(target)
    ink = (16, 78, 79, 255)
    accent = (235, 181, 79, 255)
    accent_dark = (216, 144, 43, 255)
    paper_shadow = Image.new("RGBA", target.size, (0, 0, 0, 0))
    shadow_draw = ImageDraw.Draw(paper_shadow)
    page_bounds = (240, 156, 784, 858)
    shadow_draw.rounded_rectangle(page_bounds, radius=140, fill=(15, 48, 58, 64))
    paper_shadow = paper_shadow.filter(ImageFilter.GaussianBlur(26))
    target.alpha_composite(paper_shadow)

    draw.rounded_rectangle(page_bounds, radius=140, fill=page_fill)
    draw.rounded_rectangle((240, 156, 784, 292), radius=140, fill=(17, 121, 117, 255))
    draw.rectangle((240, 226, 784, 292), fill=(17, 121, 117, 255))

    for x in (340, 512, 684):
        draw.ellipse((x - 24, 126, x + 24, 174), fill=(239, 253, 250, 255))
        draw.ellipse((x - 8, 126, x + 8, 174), fill=(17, 121, 117, 255))

    draw.rounded_rectangle((290, 330, 340, 690), radius=24, fill=(250, 227, 173, 255))
    draw.polygon([(290, 690), (340, 690), (315, 742)], fill=(230, 170, 60, 255))

    line_points = [(408, 756), (448, 646), (520, 580), (478, 496), (552, 424)]
    draw.line(line_points, fill=ink, width=34, joint="curve")
    for cx, cy in line_points:
        draw.ellipse((cx - 28, cy - 28, cx + 28, cy + 28), fill=(239, 253, 250, 255))
        draw.ellipse((cx - 16, cy - 16, cx + 16, cy + 16), fill=ink)

    draw.rounded_rectangle((424, 332, 600, 356), radius=12, fill=ink)
    draw.rectangle((448, 356, 474, 456), fill=ink)
    draw.rectangle((550, 356, 576, 456), fill=ink)
    draw.rounded_rectangle((456, 388, 568, 516), radius=32, outline=ink, width=24)

    draw.polygon([(600, 324), (666, 354), (600, 382)], fill=accent)
    draw.ellipse((626, 374, 706, 454), fill=accent_dark)

    for y in (576, 640, 704):
        draw.rounded_rectangle((604, y, 722, y + 24), radius=12, fill=(197, 227, 221, 255))


def generate_base_icon() -> Image.Image:
    base = gradient_background()
    accent_layer = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    accent_draw = ImageDraw.Draw(accent_layer)
    accent_draw.ellipse((64, 72, 320, 328), fill=(255, 255, 255, 28))
    accent_draw.ellipse((712, 712, 980, 980), fill=(16, 78, 79, 26))
    accent_layer = accent_layer.filter(ImageFilter.GaussianBlur(18))
    base.alpha_composite(accent_layer)
    draw_symbol(base, (255, 252, 245, 255))
    return base


def generate_foreground_icon() -> Image.Image:
    foreground = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    draw_symbol(foreground, (255, 252, 245, 255))
    return foreground


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    generate_base_icon().save(OUTPUT_DIR / "campus_flow_icon.png")
    generate_foreground_icon().save(OUTPUT_DIR / "campus_flow_icon_foreground.png")


if __name__ == "__main__":
    main()
