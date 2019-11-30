class CartComponent extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
		return (<div>CartView</div>)
	}
}

// Add style
const CartView = withStyles(styles, {
  withTheme: true
})(CartComponent)
