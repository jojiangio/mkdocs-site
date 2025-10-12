# Containerfile Essentials

All instructions define layers or metadata for building container images.

| Instruction         | What It Does                                                                     |
| ------------------- | -------------------------------------------------------------------------------- |
| `FROM <image>`      | Sets a **base image**. First line must be `FROM`.         |
| `WORKDIR <dir>`     | Sets the **working directory** for following instructions; created if missing.   |
| `COPY <src> <dest>` | Copies files/directories from the build context into the image.                  |
| `ADD <src> <dest>`  | Like `COPY`, but can fetch files from URLs and auto-unpack tar archives.         |
| `RUN <command>`     | Executes a shell command *during build*, committing the outcome to a new layer.  |
| `ENTRYPOINT [..]`   | Defines the **main executable** for the container at runtime.                    |
| `CMD [..]`          | Sets **default arguments** or commands, used with or without `ENTRYPOINT`.       |
| `USER <user>`       | Switches to a non-root user for subsequent steps and at runtime.                 |
| `LABEL <k>=<v>`     | Adds metadata (key="value")                                                       |

