# 📂 Directory & File Organizer

## 📝 Description
This Bash script automatically organizes files into directories based on their file type. It helps keep your workspace tidy by categorizing files like images, documents, and videos into designated folders.

## 🚀 Features
✅ Automatically sorts files into folders based on extensions

✅ Works on any directory (default: current directory)

✅ Customizable categories (e.g., add new file types)

✅ Prevents overwriting existing files

## 📦 Installation

```bash
git clone https://github.com/gonzalobarrazueta/file-directory-organizer.git

cd file-directory-organizer
```

## 🎮 Usage

Specify a target directory you want to organize:

```bash
./organize-files.sh path/to/directory
```
If you don't specify the target directory, the script will organize all files in the directory you're currently in.

## 📁 Default Categories

Your files will be organized into the following directories.

| File Type | Extensions              | Destination Folder |
| --------- | ----------------------- | ------------------ |
| Images    | `.jpg`, `.png`, `.gif`  | Pictures/          |
| Documents | `.pdf`, `.docx`, `.txt` | Documents/         |
| Videos    | `.mp4`, `.mkv`, `.avi`  | Videos/            |
| Music     | `.mp3`, `.wav`, `.flac` | Music/             |
| Archives  | `.zip`, `.tar`, `.gz`   | Archives/          |

These categories can be customized in the script.

## 🚂 How It Works

1. The script scans the specified directory.
2. It checks each file's extension and moves it to the appropriate folder.
3. If a folder doesn’t exist, it creates it automatically.

### ✨ Example Output

Before running the script:

```
/Downloads
  ├── photo.jpg
  ├── resume.pdf
  ├── song.mp3
  ├── video.mp4
```` 

After running the script:

```
/Downloads
  ├── Pictures/photo.jpg
  ├── Documents/resume.pdf
  ├── Music/song.mp3
  ├── Videos/video.mp4
```

## 🎨 Customization
