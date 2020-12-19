
# Note: You can use any Debian/Ubuntu based image you want. 
FROM voxgraph_dev_vim:latest

RUN chsh -s /bin/bash lxy && \
  yes lxy19961002 | passwd lxy
ENV HOME /home/lxy
RUN apt update \
    && apt install -y openssh-server \
                      xauth \
    && mkdir /root/.ssh \
    && chmod 700 /root/.ssh \
    && ssh-keygen -A \
    && sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config \
    && sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config \
    && grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_config


#ENTRYPOINT ["sh", "-c", "/usr/sbin/sshd && tail -f /dev/null"]
WORKDIR /workspaces/voxgraph_melodic_ws/
ENTRYPOINT [ "/ros_entrypoint.sh" ]
# CMD [ "sleep", "infinity" ]

#CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_test_clion"]
CMD ["sh", "-c", "/usr/sbin/sshd && tail -f /dev/null"]
# CMD ["/bin/bash"]
