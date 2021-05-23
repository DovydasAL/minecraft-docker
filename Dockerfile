FROM binhex/arch-base:latest

VOLUME /server

EXPOSE 25566

ADD * /server/

RUN chmod +x /server/start.sh
RUN chmod +x /server/forge-1.12.2-14.23.5.2846-universal.jar
RUN sh /server/start.sh

CMD ["/bin/bash", "/server/run.sh"]
