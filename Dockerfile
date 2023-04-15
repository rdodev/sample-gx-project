FROM ubuntu:22.04
LABEL author="Ruben Orduz"
#requirements
RUN apt-get update -y && \
    apt install software-properties-common -y && \
    apt-get install python3 python3-pip -y && \
    python3 -m pip install --upgrade pip
# install GX
RUN pip3 install great_expectations

# Add work directory
WORKDIR /app

COPY . /app/

