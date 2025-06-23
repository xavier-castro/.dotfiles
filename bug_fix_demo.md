# xa_clip Title Editing Bug Fix

## Problem Description

The `xa_clip` script had a bug where when users were asked to edit the title of a note, the entire web content would be pre-populated in the title input field. This made it impossible to edit the title because:

1. The input field would contain hundreds or thousands of characters
2. Users couldn't see or easily edit the actual title
3. The UI became unusable for web content

## Root Cause

The issue was in the title extraction logic around lines 365-375 in the original script:

### Before (Problematic Code)
```bash
# For non-URL content, use first line as title, clean it up
title=$(echo "$clipboard_content" | head -1 | sed 's/^[[:space:]]*//' | cut -c1-50)
```

This approach had several problems:
- It took the first line of content, which for HTML could be very long
- Even with `cut -c1-50`, HTML markup made titles messy
- No special handling for HTML/web content
- The gum input error handling used `2>/dev/null || echo "$title"` which could cause issues

## Solution

### 1. Improved Title Extraction
Added intelligent content detection and extraction:

```bash
# Detect HTML content
is_html_content() {
    local content="$1"
    if echo "$content" | grep -q -i -E '<(html|head|body|title|div|p|span|script|style)'; then
        return 0
    fi
    # ... more checks
}

# Extract title from HTML
extract_html_title() {
    local content="$1"
    local title=""
    
    # Try to extract HTML title tag
    title=$(echo "$content" | grep -i '<title>' | sed 's/<[^>]*>//g' | head -1 | xargs)
    
    # If no title tag, try H1 tags
    if [[ -z "$title" ]]; then
        title=$(echo "$content" | grep -i '<h1>' | sed 's/<[^>]*>//g' | head -1 | xargs)
    fi
    
    # Clean up and limit length
    title=$(echo "$title" | sed 's/[^a-zA-Z0-9[:space:]._-]//g' | cut -c1-40 | xargs)
    
    echo "$title"
}
```

### 2. Better Content Handling
```bash
if is_html_content "$clipboard_content"; then
    log_info "Detected HTML content in clipboard"
    title=$(extract_html_title "$clipboard_content")
    
    if [[ -z "$title" ]] || [[ ${#title} -lt 3 ]]; then
        title="Web Content $(date +%H:%M)"
    fi
else
    # Handle plain text content appropriately
    local first_line=$(echo "$clipboard_content" | head -1 | sed 's/^[[:space:]]*//' | sed 's/[{}()\[\]#*_`]//g')
    title=$(echo "$first_line" | cut -d' ' -f1-6 | cut -c1-40 | sed 's/[^a-zA-Z0-9[:space:]._-]//g' | xargs)
    
    if [[ -z "$title" ]] || [[ ${#title} -lt 3 ]]; then
        title="Note $(date +%H:%M)"
    fi
fi
```

### 3. Fixed Input Handling
```bash
# Before (problematic)
new_title=$(gum input --value "$title" --width 60 2>/dev/null || echo "$title")

# After (fixed)
new_title=$(gum input --value "$title" --width 60 --placeholder "Edit the title..." || true)
if [[ -n "$new_title" ]] && [[ "$new_title" != "$title" ]]; then
    title="$new_title"
elif [[ -z "$new_title" ]]; then
    log_info "Keeping original title: $title"
fi
```

## Results

### Before the Fix
- User copies web content
- Script asks for title with entire HTML content pre-filled
- Title field shows: `<!DOCTYPE html><html><head><title>Real Title</title><meta charset="utf-8"><meta name="viewport"...` (hundreds of characters)
- User cannot easily edit or see the actual title

### After the Fix
- User copies web content  
- Script intelligently extracts title from HTML `<title>` or `<h1>` tags
- Title field shows: `Real Title` (clean, short, editable)
- User can easily edit the title or press Enter to keep it

## Benefits

1. **Clean Titles**: Extracts meaningful titles from HTML content
2. **Usable UI**: Title field is no longer overwhelmed with markup
3. **Smart Fallbacks**: Handles edge cases with reasonable defaults
4. **Better UX**: Users can actually edit titles instead of fighting with long strings
5. **Content-Aware**: Different handling for URLs, HTML, plain text, and markdown

## Testing

The fix handles various content types:
- ✅ HTML pages with `<title>` tags
- ✅ HTML content with `<h1>` headings  
- ✅ Plain text content
- ✅ Markdown content
- ✅ URLs
- ✅ Very long content (truncated appropriately)
- ✅ Empty or whitespace-only content
- ✅ Content with special characters

The title editing interface now works as expected, allowing users to easily modify titles without being overwhelmed by raw web content.