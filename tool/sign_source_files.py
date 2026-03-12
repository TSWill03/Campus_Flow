# Signature: dev.tswicolly03

from __future__ import annotations

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SIGNATURE = "Signature: dev.tswicolly03"

PREFIX_BY_SUFFIX = {
    ".dart": "// ",
    ".md": "<!-- ",
    ".yaml": "# ",
    ".yml": "# ",
    ".kts": "// ",
    ".kt": "// ",
    ".swift": "// ",
    ".xml": "<!-- ",
    ".html": "<!-- ",
    ".cpp": "// ",
    ".cc": "// ",
    ".h": "// ",
    ".hpp": "// ",
    ".cmake": "# ",
    ".plist": None,
    ".json": None,
    ".png": None,
    ".ico": None,
}

SUFFIX_END = {
    ".md": " -->",
    ".xml": " -->",
    ".html": " -->",
}

ROOTS = [
    ROOT / "lib",
    ROOT / "test",
    ROOT / "android" / "app" / "src" / "main",
    ROOT / "ios" / "Runner",
    ROOT / "web",
    ROOT / "windows" / "runner",
    ROOT / "tool",
]

SINGLE_FILES = [
    ROOT / "README.md",
    ROOT / "pubspec.yaml",
]

EXCLUDED_SUFFIXES = (
    ".freezed.dart",
    ".g.dart",
    ".jar",
    ".wasm",
    ".js",
    ".map",
    ".bat",
    ".gradle",
    ".iml",
)

EXCLUDED_NAMES = {
    "GeneratedPluginRegistrant.java",
    "GeneratedPluginRegistrant.h",
    "GeneratedPluginRegistrant.m",
    "generated_plugin_registrant.cc",
    "generated_plugin_registrant.h",
    "flutter_export_environment.sh",
    "AppFrameworkInfo.plist",
    "manifest.json",
}

EXCLUDED_PARTS = {
    ".dart_tool",
    "build",
    "ephemeral",
    "AppIcon.appiconset",
    "LaunchImage.imageset",
    "icons",
    "mipmap-",
}


def iter_target_files() -> list[Path]:
    files: list[Path] = []
    for root in ROOTS:
        if not root.exists():
            continue
        for path in root.rglob("*"):
            if path.is_dir():
                continue
            if any(part in str(path) for part in EXCLUDED_PARTS):
                continue
            if path.name in EXCLUDED_NAMES:
                continue
            if any(str(path).endswith(suffix) for suffix in EXCLUDED_SUFFIXES):
                continue
            if path.suffix not in PREFIX_BY_SUFFIX:
                continue
            if PREFIX_BY_SUFFIX[path.suffix] is None:
                continue
            files.append(path)

    for path in SINGLE_FILES:
        if path.exists():
            files.append(path)

    return sorted(set(files))


def build_signature_line(path: Path) -> str:
    prefix = PREFIX_BY_SUFFIX[path.suffix]
    suffix = SUFFIX_END.get(path.suffix, "")
    return f"{prefix}{SIGNATURE}{suffix}"


def main() -> None:
    for path in iter_target_files():
        content = path.read_text(encoding="utf-8")
        if SIGNATURE in content:
            continue

        signature_line = build_signature_line(path)
        if content.startswith("#!"):
            first_line, _, remaining = content.partition("\n")
            updated = f"{first_line}\n{signature_line}\n{remaining}"
        elif path.suffix == ".xml" and content.startswith("<?xml"):
            first_line, _, remaining = content.partition("\n")
            updated = f"{first_line}\n{signature_line}\n{remaining}"
        elif path.suffix == ".html" and content.lstrip().lower().startswith("<!doctype"):
            first_line, _, remaining = content.partition("\n")
            updated = f"{first_line}\n{signature_line}\n{remaining}"
        else:
            updated = f"{signature_line}\n\n{content}"

        path.write_text(updated, encoding="utf-8")


if __name__ == "__main__":
    main()
