def normalise(input_time):
    """
    Args:
        input_time (int)
    """
    print input_time

    finished = None

    # This produces a formatted string like:
    #   Thu_Nov_24:18:22:48_1986
    str_time = format_time(input_time)

    while str_time[1:4] != "Sun":
        input_time -= 24*60*60
        str_time = format_time(input_time)

    while str_time[11:13] != "00":
        input_time -= 60*60
        str_time = format_time(input_time)

    while str_time[14:16] != "00":
        str_time = format_time(input_time)
        input_time -= 60

    while str_time[17:19] != "00":
        input_time -= 1
        str_time = format_time(input_time)

    return input_time

print normalise("Thu_Nov_24:18:22:48_1986")