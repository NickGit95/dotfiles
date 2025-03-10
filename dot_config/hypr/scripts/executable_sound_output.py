#!/usr/bin/env python
import subprocess
import sys


# function to parse output of command "wpctl status" and return a dictionary of sinks with their id and name.
def parse_wpctl_status():
    # Execute the wpctl status command and store the output in a variable.
    output = str(subprocess.check_output("wpctl status", shell=True, encoding="utf-8"))

    # remove the ascii tree characters and return a list of lines
    lines = (
        output.replace("├", "")
        .replace("─", "")
        .replace("│", "")
        .replace("└", "")
        .splitlines()
    )

    # get the index of the Sinks line as a starting point
    sinks_index = 0
    for index, line in enumerate(lines):
        if "Sinks:" in line:
            sinks_index = index
            break

    # start by getting the lines after "Sinks:"
    # and before the next blank line and store them in a list
    sinks = []
    for line in lines[sinks_index + 1 :]:
        if not line.strip():
            break
        sinks.append(line.strip())

    # remove the "[vol:" from the end of the sink name
    for index, sink in enumerate(sinks):
        sinks[index] = sink.split("[vol:")[0].strip()

    # strip the * from the default sink and instead append "- Default" to the end.
    for index, sink in enumerate(sinks):
        # print(sink[index])
        if sink.startswith("*"):
            sinks[index] = sink.strip().replace("*", "").strip() + " - Default"

    # make the dictionary in this format {'sink_id': <int>, 'sink_name': <str>}
    sinks_dict = [
        {"sink_id": int(sink.split(".")[0]), "sink_name": sink.split(".")[1].strip()}
        for sink in sinks
    ]

    return sinks_dict


# get the list of sinks ready to put into wofi - highlight the current default sink
OUTPUT = ""
sink_list = parse_wpctl_status()
for items in sink_list:
    if items["sink_name"].endswith(" - Default"):
        OUTPUT += f"☆ {items['sink_name']}\n"
    else:
        OUTPUT += f"{items['sink_name']}\n"

# Take the selected sink name and set it as the default sink
RUNNER_COMMAND = f"echo '{OUTPUT}' | fuzzel -d -w 25 -l 3"
runner_process = subprocess.run(
    RUNNER_COMMAND,
    shell=True,
    encoding="utf-8",
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    check=True,
)

if runner_process.returncode != 0:
    sys.exit("User cancelled the operation.")

selected_sink_name = runner_process.stdout.strip().replace("☆", "").strip()
selected_sink = next(
    sink for sink in sink_list if sink["sink_name"] == selected_sink_name
)
subprocess.run(f"wpctl set-default {selected_sink['sink_id']}", shell=True, check=True)
