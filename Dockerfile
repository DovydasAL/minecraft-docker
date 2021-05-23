FROM binhex/arch-base:latest

VOLUME /server

EXPOSE 25566

RUN ./server/start.sh


