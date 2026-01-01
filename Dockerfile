FROM nvcr.io/nvidia/vllm:25.09-py3

ARG UID
ARG GID

# Create a user with that specific ID
# If the UID/GID already exists (common in Ubuntu-based images), rename the existing user/group to 'unsloth'
RUN if [ -z "$UID" ]; then UID=1000; fi && \
    if [ -z "$GID" ]; then GID=1000; fi && \
    if getent group $GID; then \
        groupmod -n unsloth $(getent group $GID | cut -d: -f1); \
    else \
        groupadd -g $GID unsloth; \
    fi && \
    if getent passwd $UID; then \
        usermod -l unsloth -g $GID -d /home/unsloth -m $(getent passwd $UID | cut -d: -f1); \
    else \
        useradd -m -u $UID -g $GID unsloth; \
    fi

WORKDIR /app

RUN chown -R unsloth:unsloth /app

RUN pip install transformers peft "datasets==4.3.0" "trl==0.19.1" && \
	pip install --no-deps unsloth unsloth_zoo && \
	pip install hf_transfer && \
	pip install --no-deps bitsandbytes && \
	pip install synthetic-data-kit deepeval google-genai wandb

USER unsloth

CMD ["jupyter-lab", \
    "--ip=0.0.0.0", \
    "--port=8888", \
    "--no-browser", \
    "--ServerApp.token=''", \
    "--ServerApp.password=''", \
    "--notebook-dir=/app"]
