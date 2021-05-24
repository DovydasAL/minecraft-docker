FROM binhex/arch-base:latest

VOLUME /server

EXPOSE 25566

ADD * /server/

RUN chmod +x /server/start.sh
RUN chmod -R 777 /server
RUN sh /server/start.sh
RUN ls -l /server/

ENTRYPOINT ["/bin/bash", "/server/run.sh"]
