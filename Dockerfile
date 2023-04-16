FROM ubuntu:22.04
LABEL author="Ruben Orduz"
#requirements
RUN apt-get update -y && \
    apt install software-properties-common -y && \
    apt-get install python3 python3-pip -y && \
    apt-get install curl git -y && \
    python3 -m pip install --upgrade pip
# install GX
RUN pip3 install great_expectations

# Add work directory
WORKDIR /app

RUN git clone https://github.com/rdodev/sample-gx-project.git .

CMD [ "python3", "demo-sample.py" ]

# HELLO CHANGES!

