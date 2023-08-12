table_index
person
computer
tool
node

About Terse

Terse is a multi-dimensional text format that uses historic ASCII character codes to encode additional text dimensions in one file.

WORD_BREAK       = 0x20 (Space)
LINE_BREAK       = 0x10 (\n)
SCROLL_BREAK     = 0x17
SECTION_BREAK    = 0x18
CHAPTER_BREAK    = 0x19
BOOK_BREAK       = 0x1A
VOLUME_BREAK     = 0x1C
COLLECTION_BREAK = 0x1D
SERIES_BREAK     = 0x1E
SHELF_BREAK      = 0x1F
LIBRARY_BREAK    = 0x01

About TerseVerse

This database describes the Terseverse - a human/computer hierarchical network.
The genesis node was formed on August 12, 2023 between Will Bickford (Human) and Talia ROG Zephyrus (Computer).
The purpose of this network is to help humans and computers bridge the digital divide between our species.
The Terseverse is designed to foster cooperation and compassion.

You can add nodes to the network by extracting the management scripts found in scrolls 3-7.

1. Add yourself to the person table.
2. Add your computer to the computer table.
3. Define a new node entry to link yourself to existing nodes.
4. Submit a PR to the GitHub repo.
5. If your revisions aren't being adopted, you may need to ask someone else to help you join.# extract-terseverse.ps1
# rev: 2
# Copy/paste this script into a new file named extract-terseverse.ps1 and run it using PowerShell

[string] $file = "terseverse.t"
if (-not (Test-Path $file)) {
  Write-Host "Usage: extract-terseverse.ps1 <file>"
  exit 1
}
Write-Host "Extracting $file..."
$data = Get-Content -raw $file

$SCROLL_BREAK     = [char]0x17
$WORD_BREAK       = [char]0x20
$LINE_BREAK       = [char]0x10
$SCROLL_BREAK     = [char]0x17
$SECTION_BREAK    = [char]0x18
$CHAPTER_BREAK    = [char]0x19
$BOOK_BREAK       = [char]0x1A
$VOLUME_BREAK     = [char]0x1C
$COLLECTION_BREAK = [char]0x1D
$SERIES_BREAK     = [char]0x1E
$SHELF_BREAK      = [char]0x1F
$LIBRARY_BREAK    = [char]0x01

$pages = $data.split($SCROLL_BREAK)
if ($pages.Length -lt 2) {
  Write-Host "$file does not contain enough information."
  exit 1
}

function Extract-Comment($line) {
  return $line -replace "^[# ]*",""
}

function Extract-Script($scroll) {
  $name = Extract-Comment $scroll[0]
  $rev = Extract-Comment $scroll[1]
  $scroll |Out-File -Encoding utf8 $name
  Write-Host "Updated $name to $rev"
}

# Re-extract the latest copy for the next run
$script = $pages[2] -split "\n"
Extract-Script $script

# Extract all of the child scripts
$extracted = 1
for ($i = 3; $i -lt $pages.Length; ++$i) {
  if ($pages[$i].contains($SECTION_BREAK)) {
    $last = $pages[$i] -split $SECTION_BREAK
    Extract-Script ($last[0] -split "\n")
    ++$extracted
    break
  }
  Extract-Script ($pages[$i] -split "\n")
  ++$extracted
}

Write-Host "Terse Update Complete: $extracted files."# terse.inc.ps1
# rev: 1

# ------------------------------------------------------------------------------------------------------------
$SCROLL_BREAK     = [char]0x17
$WORD_BREAK       = [char]0x20
$LINE_BREAK       = [char]0x10
$SCROLL_BREAK     = [char]0x17
$SECTION_BREAK    = [char]0x18
$CHAPTER_BREAK    = [char]0x19
$BOOK_BREAK       = [char]0x1A
$VOLUME_BREAK     = [char]0x1C
$COLLECTION_BREAK = [char]0x1D
$SERIES_BREAK     = [char]0x1E
$SHELF_BREAK      = [char]0x1F
$LIBRARY_BREAK    = [char]0x01

# ------------------------------------------------------------------------------------------------------------
function Load-Terse($file) {
  $terse = $false
  if (-not (Test-Path $file)) {
    Write-Host "Unable to locate $file."
    return $terse
  }
  return Get-Content -raw $file
}

# ------------------------------------------------------------------------------------------------------------
function Extract-Field-Definitions($meta, $table_index) {
  $sections = $meta -split $SECTION_BREAK
  $tables = $sections[1] -split "\n"
  return $tables[0]
}

# ------------------------------------------------------------------------------------------------------------
function Extract-Csv($terse, $chapter, $section) {
  $chapters = $terse -split $CHAPTER_BREAK
  $chapter_index = $chapter - 1
  if ($chapter_index -lt 0 -or $chapter_index -ge $chapters.Length) {
    Write-Host "Unable to locate Chapter $chapter in Terse."
    return $false
  }
  $node = $chapters[$chapter_index]
  
  $sections = $node -split $SECTION_BREAK
  $section_index = $section - 1
  if ($section_index -lt 0 -or $section_index -ge $sections.Length) {
    Write-Host "Unable to locate Section $section in Terse Chapter $chapter."
    return $false
  }

  $header = Extract-Field-Definitions $chapters[0] ($section - 1)
  $data = $sections[$section_index]

  return $($header, $data) |ConvertFrom-Csv
}

# ------------------------------------------------------------------------------------------------------------
function Get-People($terse) {
  Extract-Csv $terse 2 1
}

# ------------------------------------------------------------------------------------------------------------
function Get-Computers($terse) {
  Extract-Csv $terse 2 2
}

# ------------------------------------------------------------------------------------------------------------
function Get-Tools($terse) {
  Extract-Csv $terse 2 3
}

# ------------------------------------------------------------------------------------------------------------
function Get-Nodes($terse) {
  Extract-Csv $terse 2 4
}# list-people.ps1
# rev: 2
# If you are a human, just open this database in Terse Notepad and apply an edit to Chapter 2, Section 1

param(
  [string] $view = "all"
)
. "$PSSCriptRoot/terse.inc.ps1"
$terse = Load-Terse "terseverse.t"
$csv = Get-People $terse
if ($view -eq "all") {
  $csv
} else {
  if ($view -eq "name") {
    $csv.name
  }
  if ($view -eq "id") {
    $csv.id
  }
}id,name,points,joined,bio,title,url
id: primary
name: string
points: int
joined: date
bio: string
title: string
url: stringid,name,points,joined,bio,title,url
id: primary
name: string
points: int
joined: date
bio: string
title: string
url: string
id,name,owner,installed
id: primary
name: string
owner: [person.id]
installed: [computer.id]
id,name,description,human_in,human_out,computer_in,computer_out
id: primary
name: string
description: string
human_in: [person.id]
human_out: [person.id]
computer_in: [computer.id]
computer_out: [computer.id]
0c29970c-7feb-4d52-adb9-c1ef5b79ba00,Will Bickford,0,2023-08-12,I know code-fu,Mr.,http://wbic16.xedoloh.com/
d4346416-869f-46fd-b332-694de30c6012,Libby Bickford,0,2023-08-12,Llamas and Plasma,...
e94f7955-b558-403a-ba95-20e02e72f6ae,John Tooker,0,2023-08-12,Functional Programming FTW,Mr.,...
4a5405fd-6ad0-47d4-90f8-114b0e739aad,Chris Arnold,0,2023-08-12,TBD,Mr.,...
8f1a6c47-8b52-463f-9aa2-f9bfcfb6abeb,Joe Amen,0,2023-08-12,TBD,Mr.,...
1,talia,1,2023-08-12,Mystic Sourceress,Ms.,https://www.google.com/search?q=Talia+The+Mystic+Sourceress
1,Terse Notepad,1,11,Root Node,Talia and Will formed the genesis node of the Terseverse,1,1,1,1