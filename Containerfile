FROM fedora:latest

ADD .stack-work/dist/x86_64-linux-tinfo6/Cabal-3.2.1.0/build /app

WORKDIR /app

CMD /app/PrimeGen-exe/PrimeGen-exe
