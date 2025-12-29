import marimo

app = marimo.App(width="medium")

@app.cell(hide_code=True)
def _(mo):
    mo.md(
        r"""
        # Matplotlib: Select colormap

        This snippet creates a marimo widget to select colormap from matplotlib.pyplot
        """
    )
    return

#magic_start_parse
@app.cell
def _():
    import marimo as mo
    from matplotlib.pyplot import colormaps

    snippets_select_cmap = colormaps()
    return (snippets_select_cmap, mo)


@app.cell
def _(mo, snippets_select_cmap):
    dropdown_colormaps  = mo.ui.dropdown(snippets_select_cmap, value="viridis", label="Select colormaps")
    return (dropdown_colormaps, )


@app.cell
def _(dropdown_colormaps):
    dropdown_colormaps
    return


@app.cell
def _(dropdown_colormaps):
    dropdown_colormaps.value
    return
#magic_end_parse


if __name__ == "__main__":
    app.run()

