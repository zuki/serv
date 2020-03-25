# ZephyrでHello World Appを作成する

"Gettting Started Guide"を一部変更して実行

1. "Select and Update OS" はUbuntuを選択してそのまま実行
2. "Install dependencies"の1, 2, 3を実行
3. "Get the source code"は以下の通り変更して実行

  ```bash
  $ cd $SERV
  $ west init -m https://github.com/zuki/zephyr --mr serv1.14.1 zephyrproject

  === Initializing in /home/vagrant/develop/riscv/serv/zephyrproject
  --- Cloning manifest repository from https://github.com/zuki/zephyr, rev. serv1.14.1
  Initialized empty Git repository in /home/vagrant/develop/riscv/serv/zephyrproject/.west/manifest-tmp/.git/
  ...
  a690d52fa69f812924aa38f20c45f707c64fa16f refs/remotes/origin/serv1.14.1
  Checking out files: 100% (13088/13088), done.
  Branch 'serv1.14.1' set up to track remote branch 'serv1.14.1' from 'origin'.
  Switched to a new branch 'serv1.14.1'
  --- setting manifest.path to zephyr
  === Initialized. Now run "west update" inside /home/vagrant/develop/riscv/serv/zephyrproject.

  $ cd zephyrproject
  $ west update

  === updating ci-tools (tools/ci-tools):
  --- ci-tools: initializing
  Initialized empty Git repository in /home/vagrant/develop/riscv/serv/zephyrproject/tools/ci-tools/.git/
  ...
  === updating net-tools (net-tools):
  --- net-tools: initializing
  Initialized empty Git repository in /home/vagrant/develop/riscv/serv/zephyrproject/net-tools/.git/
  ...
  === updating tinycbor (modules/lib/tinycbor):
  --- tinycbor: initializing
  Initialized empty Git repository in /home/vagrant/develop/riscv/serv/zephyrproject/modules/lib/tinycbor/.git/
...
  ```

4. "Install needed Phython package"を実行
5. "Install Software Development Toolchanin"を実行して`riscv64-zephyr-elf`のみ使用

  ```bash
  $ mv riscv64-zephyr-elf /usr/local
  $ vi ~/.bashrc

  export ZEPHYR_BASE=$SERV/zephyrproject
  export ZEPHYR_TOOLCHAIN_VARIANT=cross-compile
  export CROSS_COMPILE=/usr/local/riscv64-zephyr-elf/bin/riscv64-zephyr-elf-
  ```

6. "Build the Hello World Application"

  ```bash
  $ cd zephyrproject/zephyr
  $ source zephyr-env.sh
  $ west build -p auto -b service samples/hello_world

  source directory: /home/vagrant/develop/riscv/serv/zephyrproject/zephyr/samples/hello_world
  build directory: /home/vagrant/develop/riscv/serv/zephyrproject/zephyr/build (created)
  BOARD: service
  Zephyr version: 1.14.1
  -- Found PythonInterp: /usr/bin/python3 (found suitable version "3.6.9", minimum required is "3.4")
  -- Selected BOARD service
  -- Found west: /home/vagrant/.local/bin/west (found suitable version "0.7.2", minimum required is "0.5.6")
  Parsing Kconfig tree in /home/vagrant/develop/riscv/serv/zephyrproject/zephyr/Kconfig
  Loading /home/vagrant/develop/riscv/serv/zephyrproject/zephyr/boards/riscv32/service/service_defconfig as base
  Merging /home/vagrant/develop/riscv/serv/zephyrproject/zephyr/samples/hello_world/prj.conf
  Configuration written to '/home/vagrant/develop/riscv/serv/zephyrproject/zephyr/build/zephyr/.config'
  -- Cache files will be written to: /home/vagrant/.cache/zephyr
  -- The C compiler identification is GNU 9.2.0
  -- The CXX compiler identification is GNU 9.2.0
  -- The ASM compiler identification is GNU
  -- Found assembler: /usr/local/riscv64-zephyr-elf/bin/riscv64-zephyr-elf-gcc
  -- Performing Test toolchain_is_ok
  -- Performing Test toolchain_is_ok - Success
  Including module: tinycbor in path: /home/vagrant/develop/riscv/serv/zephyrproject/modules/lib/tinycbor
  -- Configuring done
  -- Generating done
  -- Build files have been written to: /home/vagrant/develop/riscv/serv/zephyrproject/zephyr/build
  [3/89] Preparing syscall dependency handling

  [84/89] Linking C executable zephyr/zephyr_prebuilt.elf
  Memory region         Used Size  Region Size  %age Used
               RAM:       14096 B        32 KB     43.02%
          IDT_LIST:          25 B         2 KB      1.22%
  [89/89] Linking C executable zephyr/zephyr.elf
  ```

7. Servで実行

  ```bash
  $ cd zephyrproject/zephyr/build/zephyr
  $ file zephyr.elf

  zephyr.elf: ELF 32-bit LSB executable, UCB RISC-V, version 1 (SYSV), statically linked, with debug_info, not stripped

  $ cp zephyr.bin $SERV/serv/sw/zephyr_hello.bin
  $ cd $SERV/serv/sw
  $ vi Makefile
    python3 makehex.py $< 4096 > $@  # .binが2048を超えたので最大サイズを4096に変更
  $ make zephyr_hello.hex
  $ cd $SERV/workspace
  $ fusesoc run --target=max1000 servant
  ```
