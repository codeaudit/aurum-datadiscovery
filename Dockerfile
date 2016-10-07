FROM jupyter/scipy-notebook

RUN pip install \
    bitarray \
    dataset \
    elasticsearch-dsl==2.0.0 \
    elasticsearch==2.3.0 \
    nltk \
    path.py

# Prebuild matplotlib font cache
# Otherwise the first time someone does this is a notebook, they'll see warning
# messages and have to wait.
RUN python -c "import matplotlib; matplotlib.use('TkAgg'); import matplotlib.pyplot"

COPY . /home/$NB_USER/work/

# Expect an elasticsearch server available at this host and port.
RUN echo "db_host = 'elasticsearch'\n\
db_port = '9200'" > /home/$NB_USER/work/local_config.py
