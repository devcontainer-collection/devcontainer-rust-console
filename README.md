## About This DevContainer

This repository provides a DevContainer setup for Rust.
The Docker image is based on `rust:latest`.
The Docker image size is approximately 7.0GB after build.

This setup has been tested only on macOS-x86_64 and Linux-x86_64 as host platforms, with Linux-x86_64 as the container runtime. Compatibility with other environments has not been verified.

`cargo zigbuild` is used to perform cross-builds for creating self-contained executables for various platforms.

### Host Platform Compatibility for Self-Contained Executable Builds

| Target OS | Target Arch | Build         | Strip        |
|-----------|-------------|---------------|--------------|
| Windows   | x64         | OK            | OK           |
| Windows   | arm64       | OK            | OK           |
| macOS     | x64         | OK            | Not supported|
| macOS     | arm64       | OK            | Not supported|
| Linux     | x64         | OK            | OK           |
| Linux     | arm64       | OK            | OK           |

**Legend:**
- **OK**: Fully supported and tested.
- **Not supported**: Not supported for this configuration.
- **Planned**: Planned for future support.
- **Not tested**: Not yet tested.

## Support This Project

If you found this project helpful, consider supporting its maintenance and future development with a small donation.  
You can buy me a coffee via the Ko-fi link below — thank you! ☕✨  

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/B0B21CR05U)

---

## Getting Started (With Dev Containers)

### 1. Launch VSCode  
Open Visual Studio Code.

### 2. Open the Project Folder in VSCode  
Go to **File → Open Folder** and select the folder where the project is cloned.

### 3. Install VSCode Extension  
If you see a message at the bottom of VSCode saying **"Do you want to install the recommended extensions from GitHub, Microsoft and others for this repository?"**, click **Install** to install the **Dev Containers** extension along with other recommended extensions.

### 4. Reopen the Project in a Container  
Click the **bottom left corner** of the VSCode window where it says **"Open a Remote Window"** → **Reopen in Container**.  

### 5. Wait for the Container to Build and Set Up  
Wait while the **Dev Container environment prepares**. This process may include **downloading the base image**, **installing required tools and libraries**, and **building the Docker image if necessary**.  
Depending on your internet speed and system performance, this may take **a few minutes**.  
If you see a message prompting you to install recommended extensions like in the previous steps, click **Install** to install the extensions in the container environment.

### 6. Debug the Project  
Open `[WORKSPACE_FOLDER]/src/main.rs` and press **F5** to start debugging.  
The project will be **compiled and executed inside the container**, and the output will be visible in the **Terminal**.  
If you see a message in the **Debug Console** after starting the project, switch to the **Terminal** tab to find the running program.

### 7. Build Docker Runtime-Native Binary  
Open the command palette: Press **Ctrl + Shift + P** (macOS: **Cmd + Shift + P**) → **Tasks: Run Task** → **build native(release): docker runtime native**.  
This will generate an executable binary that runs natively in the Docker runtime environment.

### 8. Cross-Build the Project  
Open the command palette: Press **Ctrl + Shift + P** (macOS: **Cmd + Shift + P**) → **Tasks: Run Task** → **build all release targets**.

### Notes

The file `[WORKSPACE_FOLDER]/app/build-scripts/strip.sh` exists and functions correctly but is not currently used in the build process.
