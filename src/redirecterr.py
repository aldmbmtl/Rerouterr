"""
Main handler
"""
import yaml
from flask import Flask, render_template

app = Flask(__name__)


DEFAULT = dict(
    template="basic",
    title="Redirecterr",
    header="Welcome to Redirecterr!",
    message="This is the default welcome page. Replace it in your config.yaml!",
    embed=None,
    redirect_to="https://google.com",
    delay=0,
)


@app.route("/<path:path>")
def template_test(path):
    """
    Basic render function
    """
    with open("/config/main.yaml", "r") as config_file:
        data = yaml.load(config_file.read(), Loader=yaml.FullLoader)

    config = {**DEFAULT, **data.get(path, {})}
    return render_template(f"{config['template']}.html", **config)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
