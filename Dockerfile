FROM flopz/greenplum:4.3
MAINTAINER "Francisco Lopez" teraflopx@gmail.com

# some tricks (this should be in the base image instead)
RUN echo root:docker | chpasswd

# configure system
#COPY config/sysctl.conf /tmp/sysctl.conf
#RUN cat /tmp/sysctl.conf >> /etc/sysctl.conf
#RUN sysctl -p /etc/sysctl.conf

#COPY config/limits.conf /tmp/limits.conf
#RUN cat /tmp/limits.conf >> /etc/security/limits.conf

USER gpadmin

# configure Greenplum environment
RUN echo "source /data/greenplum/greenplum_path.sh" > /home/gpadmin/.bash_profile
RUN echo "export MASTER_DATA_DIRECTORY=/data/gpmaster/gpsne-1" >> /home/gpadmin/.bash_profile 
RUN source /home/gpadmin/.bash_profile

RUN echo "$(hostname)" > /home/gpadmin/sne_hostlist
#RUN gpssh-exkeys -f /home/gpadmin/sne_hostlist
#RUN gpcheckos -f /home/gpadmin/sne_hostlist

#COPY config/sne_gpinit /home/gpadmin/sne_gpinit
#RUN gpinitsystem -c /home/gpadmin/sne_gpinit

# expose default port and data folder
EXPOSE 22 5432
VOLUME ["/data"]

# start Greenplum
ENTRYPOINT ["/bin/bash"]
#CMD ["gpstart"]