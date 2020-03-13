FROM ubuntu:19.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get upgrade -y
    
RUN apt-get install --no-install-recommends -y \
  python3                                      \
  python3-pip                                  \
  build-essential                              \
  gdb                                          \
  valgrind                                     \
  autoconf                                     \
  git                                          \
  vim                                          \
  tmux                                         \
  clang-7                                      \
  clang-format-7                               \
  clang-tidy-7                                 \
  clang-tools-7                                \
  cmake                                        \
  lcov                                         \
  googletest

# The googletest package only installs the src, not the built lib -> build it.
# The googletest sources are no longer needed after we have built and 
# installed it -> remove it.
RUN bash -xc "pushd /usr/src/googletest;            \
              mkdir build;                          \
              cd build;                             \
              cmake ..;                             \
              make install;                         \
              cd ..;                                \
              rm -fr build;                         \
              popd;                                 \
              apt-get remove -y --purge googletest;"

RUN apt-get clean autoclean &&           \
    apt-get autoremove --yes &&          \
    rm -rf /var/lib/{apt,dpkg,cache,log}
