FROM python:3.11-slim

ARG USERNAME=robot
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ENV PATH="$PATH:/home/$USERNAME/.local/bin:/opt/chrome/:/opt/"
ENV ROBOT_OPTIONS="--outputdir results --suitestatlevel 2"
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_CACHE_DIR=1

RUN groupadd --gid $USER_GID $USERNAME \
    && echo "deb http://ftp.de.debian.org/debian sid main" >> /etc/apt/sources.list \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "alias ll='ls -la'" >> /home/$USERNAME/.bashrc \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME /opt/ \
    && apt update \
    && apt install curl unzip vim -y \
    && apt autoremove 

RUN apt install -y libnss3 \
        libnss3-dev

RUN apt install -y libatk1.0-0 \
        libatk-bridge2.0-0 \
        libcups2 \
        libdrm2 \
        libxcomposite1 \
        libxdamage1 \
        libxfixes3 \
        libxrandr2 \
        libgbm1 

RUN apt install -y libxkbcommon0 \
        libasound2 \
        xorg \
        xvfb \
        gtk2-engines-pixbuf \
        dbus-x11 \
        xfonts-base \
        xfonts-100dpi \
        xfonts-75dpi \
        libatk-bridge2.0-0 \
        libatspi2.0-0 \
        libgtk-4-1 \
        libvulkan1 \
        libxkbcommon0 \
        xfonts-scalable \
    && rm -rf /var/lib/apt/lists

COPY aux_scripts/selenium_test.py /opt/
RUN chown -R $USER_UID:$USER_GID /opt/

USER robot
WORKDIR /opt/
RUN curl -sS -Lo "/tmp/chromedriver.zip" "https://chromedriver.storage.googleapis.com/108.0.5359.71/chromedriver_linux64.zip" \
    && curl -sS -Lo "/tmp/chrome-linux.zip" "https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F1058929%2Fchrome-linux.zip?alt=media" \
    && unzip /tmp/chromedriver.zip -d /opt/ \
    && unzip /tmp/chrome-linux.zip -d /opt/ \
    && mkdir -p /opt/chrome /opt/screenshots/ \
    && cp -r /opt/chrome-linux/* /opt/chrome \
    && rm -rf /tmp/* /opt/chrome-linux/

WORKDIR /tmp/
COPY --chown=robot:robot requirements.txt .
RUN pip install --user -r requirements.txt
RUN pip cache purge

# RUN pip install --upgrade pip \
#     && pip install --user --no-warn-script-location selenium robotframework robotframework-Selenium2Library

# ENTRYPOINT ["python", "selenium_test.py"]
