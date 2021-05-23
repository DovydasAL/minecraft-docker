FROM binhex/arch-base:latest

VOLUME /server

EXPOSE 25566

ADD * /server/

RUN chmod +x /server/start.sh
CMD ["/bin/bash", "/server/start.sh"]


