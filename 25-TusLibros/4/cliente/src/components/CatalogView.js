class CatalogComponent extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    const {cartID, router} = this.props

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Book Catalog:
				</Typography>
				<BookList
					cartID={cartID}
					quantityHeading="Quantity In Cart"
					includeEntireCatalog
					router={router}
				/>
      </div>
    )
  }
}

// Add style
const CatalogView = withStyles(styles, {
  withTheme: true
})(CatalogComponent)
