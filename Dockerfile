FROM rust:latest

###################################################################################################
# Install nightly rust, but still default to stable
###################################################################################################

RUN rustup self update
RUN rustup install nightly
RUN rustup default stable

# Print versions
RUN rustup -V
RUN rustc -V
RUN cargo -V

###################################################################################################
# Install Blender
###################################################################################################

RUN apt-get update
RUN apt-get install -y libglu1
RUN curl -OL https://mirror.clarkson.edu/blender/release/Blender2.80/blender-2.80-linux-glibc217-x86_64.tar.bz2

RUN tar -xf blender-2.80-linux-glibc217-x86_64.tar.bz2
RUN rm -rf blender-2.80-linux-glibc217-x86_64.tar.bz2

RUN mv blender-2.80-linux-glibc217-x86_64 /blender
ENV PATH /blender:$PATH

###################################################################################################
# Allow us to render images within our Docker image by setting up an in memory display server
###################################################################################################

RUN apt-get update
RUN apt-get install -y mesa-utils \
    xvfb \
    libgl1-mesa-dri \
    libglapi-mesa \
    libosmesa6

ENV DISPLAY=:99.0
