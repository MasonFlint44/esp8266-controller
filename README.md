## How to build firmware
### https://nodemcu.readthedocs.io/en/release/build/
1. Run WSL
1. Navigate to `/mnt/c/nodemcu-firmware/nodemcu-firmware`
1. Edit `./app/include/user_modules.h` to add or remove modules
1. Execute `git pull`
1. Execute `sudo make`
## How to flash firmware (only required when adding or removing modules)
### https://github.com/espressif/esptool
1. Run PowerShell
1. Navigate to `C:\nodemcu-firmware\nodemcu-firmware\bin`
1. Execute the following:
    ```
    esptool.py --port COM3 write_flash -fm dio 0x00000 0x00000.bin
    esptool.py --port COM3 write_flash -fm dio 0x10000 0x10000.bin
    ```
## How to upload code
### https://github.com/andidittrich/NodeMCU-Tool
1. Run PowerShell
1. Navigate `C:\Users\mason\documents\projects\nodemcu\esp8266-controller`
1. Create initial File System (only required first time)
    - Execute: `nodemcu-tool mkfs`
1. Execute `nodemcu-tool upload <filename>`
## How to execute
1. Run Arduino IDE
1. Press `Ctrl+Shift+M` to open Serial Monitor
1. Ensure baud rate is set to at least 115200
1. Press RST button on device to restart - output should appear in Serial Monitor

## Dependencies (make sure to upload these files with code)
```
./lua_modules/http/httpserver.lua
./lua_modules/fifo/fifosock.lua
.lua_modules/fifo/fifo.lua
```