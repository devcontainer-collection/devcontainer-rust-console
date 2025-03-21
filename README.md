## Getting Started (with DevContainers)

### 1. Install VSCode Extension  
Install the **Microsoft Dev Containers** extension.

### 2. Open the Project Folder in VSCode  
Go to **File → Open Folder** and select the folder where the project is cloned.

### 3. Reopen the Project in a Container  
Click the **bottom left corner** of the VSCode window where it says **"Open a Remote Window"** → **Reopen in Container**.

### 4. Wait for the Container to Build  
Wait for the **Docker image to be built** and for the **workspace to open inside the container**.

### 5. Debug the Project  
Open `/workspace/src/main.rs` and press **F5** to start debugging.  
The project will be **compiled and executed inside the container**, and the output will be visible in the **Debug Console**.

### 6. Cross-Build the Project  
Press **Cmd + Shift + P** → **Tasks: Run Task** → **Build all release targets**.
