FROM binhex/arch-base:latest

VOLUME /server

EXPOSE 25566

ADD * /server/

RUN chmod +x /server/start.sh
RUN sh /server/start.sh


