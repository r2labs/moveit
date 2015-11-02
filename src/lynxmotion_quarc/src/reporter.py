#!/usr/bin/env python
# Written by Eric Crosson
# 2015-11-01

import time
import logging


logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(levelname)s %(message)s',
                    filename='/tmp/lynxmotion_quarc.log',
                    filemode='w')


def parametrized(dec):
    """This decorator allows a decorator to take arguments."""
    def layer(*args, **kwargs):
        def repl(f):
            return dec(f, *args, **kwargs)
        return repl
    return layer


@parametrized
def reporter(f, message, *args, **kwargs):
    """Automatically log progress on function entry and exit. Default logging
    value: info.

    *Logging with values contained in the parameters of the decorated function*
    Message may be a string to be formatted with parameters passed to the
    decorated function. Each '{}' will be replaced by the value of the next
    function argument specified in *args.

    *Keyword parameters*
    - log :: integer
      - Specifies a custom level of logging to pass to the active logger
    - print_return :: bool
      - Print the return value of the decorated method

    *Exceptions:*
    - IndexError and ValueError
      - will be returned if *args contains a string that does not correspond to
        a parameter name of the decorated function, or if there are more '{}'s
        than there are *args.

    """
    def aux(*xs, **kws):
        arg_values = []
        if args is not None:
            for arg in args:
                try:
                    if arg in kws:
                        arg_values.append(kws[arg])
                    else:
                        index = inspect.getargspec(f).args.index(arg)
                        arg_values.append(xs[index])
                except (IndexError, ValueError):
                    logging.exception('Invalid decorator arguments around method %s', f.__name__)
                    raise

        # Obtain information from decorator arguments
        report = message.format(*arg_values)
        log_level = kwargs.get('log', logging.INFO)
        print_return = kwargs.get('print_return', False)

        logging.log(log_level, '%s...', report)
        ret = None
        try:
            ret = f(*xs, **kws)
        except Exception as e:
            logging.log(log_level, '%s...threw exception %s with message %s', report, type(e).__name__, e.message)
            raise
        if print_return:
            logging.log(log_level, '%s...returning %s', ret)
        logging.log(log_level, '%s...done', report)
        return ret
    return aux


@parametrized
@reporter('Sleeping for %s seconds for %s', 'time', 'reason')
def sleeper(time, reason):
    """Sleep for %s seconds, logging reason."""
    time.sleep(time)
