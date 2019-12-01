class CartComponent extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    const {cartID, router} = this.props
		
    return (
      <div>
        <Typography component="h1" gutterBottom>
          Books that are actually in your Cart:
				</Typography>
				<BookList
					cartID={cartID}
					quantityHeading="Quantity"
					router={router}
				/>
      </div>
    )
  }
}

// Add style
const CartView = withStyles(styles, {
  withTheme: true
})(CartComponent)
