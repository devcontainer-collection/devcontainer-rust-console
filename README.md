## About This DevContainer

This repository provides a DevContainer setup for rust.
The Docker image is based on `rust:latest`.
The Docker image size is approximately 7.0GB after build.

Using `cargo zigbuild`, cross-builds are supported for generating self-contained executables for various platforms.

### Host Platform Compatibility for Self-Contained Executable Builds

The results below are based on testing with macOS-x86_64 as the host platform and Linux x86_64 in a container environment. Other host platforms and environments have not been tested.

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
Wait while the **Dev Container environment is being prepared**. This process may include **downloading the base image**, **installing required tools and libraries**, and **building the Docker image if necessary**.  
Depending on your internet speed and system performance, this may take **a few minutes**.  
If you see a message prompting you to install recommended extensions like in the previous steps, click **Install** to install the extensions in the container environment.

### 6. Debug the Project  
Open `/workspace/src/main.rs` and press **F5** to start debugging.  
The project will be **compiled and executed inside the container**, and the output will be visible in the **Terminal**.  
If you see a message in the **Debug Console** after starting the project, switch to the **Terminal** tab to find the running program.

### 7. Build Docker Runtime-Native Binary  
Open the command palette: Press **Ctrl + Shift + P** (macOS: **Cmd + Shift + P**) → **Tasks: Run Task** → **build native(release): docker runtime native**.  
This will generate an executable binary that runs natively in the Docker runtime environment.

### 8. Cross-Build the Project  
Open the command palette: Press **Ctrl + Shift + P** (macOS: **Cmd + Shift + P**) → **Tasks: Run Task** → **build all release targets**.

### Notes

The file `[WORKSAPCE]/src/build-scripts/strip.sh` exists and functions correctly but is not currently used in the build process.
