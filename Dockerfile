
# Note: You can use any Debian/Ubuntu based image you want. 
FROM voxgraph_dev_vim:latest

RUN chsh -s /bin/bash lxy && \
  yes lxy19961002 | passwd lxy

WORKDIR /workspaces/voxgraph_melodic_ws/
ENTRYPOINT [ "/ros_entrypoint.sh" ]
# CMD [ "sleep", "infinity" ]

CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_test_clion"]
# CMD ["/bin/bash"]
