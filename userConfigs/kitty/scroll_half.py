# Half-page scrollback on the main screen; full-screen apps (neovim) get the key instead.
from kittens.tui.handler import result_handler


def main(args):
    pass


@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss):
    w = boss.window_id_map.get(target_window_id)
    if w is None:
        return
    up = args[1] == 'up'
    if w.screen.is_main_linebuf():
        w.screen.scroll(max(1, w.screen.lines // 2), up)
    else:
        w.send_key('ctrl+u' if up else 'ctrl+d')
