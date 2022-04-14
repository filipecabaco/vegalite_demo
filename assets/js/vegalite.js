import vegaEmbed from "vega-embed";
const VegaLite = {
    mounted() {
        this.props = { id: this.el.getAttribute("data-id") };
        this.handleEvent(`vega_lite:${this.props.id}:init`, ({ spec }) => {
            vegaEmbed(this.el, spec)
                .then((result) => result.view)
                .catch((error) => console.error(error));
        });
    },
};

export default VegaLite;
