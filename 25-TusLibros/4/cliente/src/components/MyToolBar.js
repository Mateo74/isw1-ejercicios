class MyToolBarComponent extends React.Component {
  constructor(props) {
    super(props)
  }

	onClickCatalog() {
		this.props.router.navigate("/catalog", {})
	}
	
	onClickCart() {
		this.props.router.navigate("/cart", {})
	}
	
	onClickPurchaseHistory() {
		this.props.router.navigate("/purchaseHistory", {})
	}

  render() {
		const classes = this.props.classes

    return (
      <div className={classes.rootToolBar}>
        <AppBar position="static">
          <Toolbar>
            <Typography variant="h6" className={classes.title}>
              {this.props.title}
            </Typography>
						<Button
							color="inherit"
							onClick={(ev) => this.onClickCatalog()}>
							Catalog
						</Button>
						<Button
							color="inherit"
							onClick={(ev) => this.onClickCart()}>
							Cart
						</Button>
						<Button
							color="inherit"
							onClick={(ev) => this.onClickPurchaseHistory()}>
							Purchase History
						</Button>
						<Button
							color="inherit"
							onClick={(ev)=>{}}>
							Log Out
						</Button>
          </Toolbar>
        </AppBar>
      </div>
    )
  }

}

// Add style
const MyToolBar = withStyles(styles, {
  withTheme: true
})(MyToolBarComponent)
