FROM jupyter/minimal-notebook

USER root

RUN apt-get update && \
 apt-get install -y --no-install-recommends make curl patch file && \
 apt-get install -y --no-install-recommends gcc g++ git

# torchtext>=0.9.0では、torchtext.data.Fieldが廃止されてしまった
# 最新のgensimではgensim.models.KeyedVectors.wv が廃止されてしまった。3.8.3以前をダウンロード
RUN pip install -U pip && \
 pip install --no-cache-dir matplotlib langchain==0.0.246 chromadb tiktoken openai pypdf unstructured pdf2image python-pptx diagrams wikipedia llama-index html2text google-api-python-client && \
 rm -rf /tmp/pip-tmp & \
 chmod -R 777 /opt/conda/lib/python3.11/site-packages

RUN wget https://www.sqlite.org/src/tarball/sqlite.tar.gz && tar xzf sqlite.tar.gz && cd sqlite && ./configure && make && make install


COPY ./gihyo-ChatGPT ${HOME}/gihyo-ChatGPT
# jovyan
USER ${NB_UID}
# /home/jovyan
WORKDIR "${HOME}"/gihyo-ChatGPT/notebook