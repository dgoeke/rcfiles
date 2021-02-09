#! /usr/bin/env nix-shell
#! nix-shell shell.nix -i python

import leglight
import click
import threading

brightnessDelta = 5;
allLights = []

def threadedLightCmd(f, light):
    t = threading.Thread(target=f, args=(light,))
    t.start()
    return t

def doAll(f):
    threads = map(lambda l: threadedLightCmd(f, l), allLights)
    for t in threads:
        t.join()

@click.group()
@click.option('--lights', required=True, nargs=2, envvar='LIGHTS')
def cli(lights):
    global allLights
    allLights = map(lambda x: leglight.LegLight(x, 9123), lights)

@click.command()
def on():
    doAll(lambda x: x.on())

@click.command()
def off():
    doAll(lambda x: x.off())

@click.command()
def toggle():
    doAll(lambda x: x.off() if x.isOn else x.on())

@click.command()
def brighter():
    doAll(lambda x: x.brightness(min(100, x.isBrightness + brightnessDelta)))

@click.command()
def dimmer():
    doAll(lambda x: x.brightness(max(0, x.isBrightness - brightnessDelta)))

@click.command()
@click.argument('level')
def brightness(level):
    doAll(lambda x: x.brightness(int(level)))

@click.command()
def status():
    doAll(lambda x: click.echo(vars(x)))

cli.add_command(on)
cli.add_command(off)
cli.add_command(brighter)
cli.add_command(dimmer)
cli.add_command(brightness)
cli.add_command(status)
cli.add_command(toggle)

if __name__ == '__main__':
    cli()
