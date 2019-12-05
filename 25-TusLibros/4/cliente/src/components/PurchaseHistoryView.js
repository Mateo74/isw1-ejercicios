class PurchaseHistoryComponent extends React.Component {
    constructor(props) {
        super(props)

        this.state = {purchaseHistory: []}
    }

    buildPurchaseHistoryFrom(catalog, clientPurchases) {
        let purchaseHistory = []
        Object.keys(clientPurchases).forEach(isbn => 
            purchaseHistory.push({title: catalog[isbn].title, quantityPurchased: clientPurchases[isbn]})
        )
        return purchaseHistory
    }

    componentDidMount() {
        const {clientID, clientPassword, router} = this.props
        let catalog = {}
        let clientPurchases = {}

        handleErrors(router, request("catalog")
            .then(responseBody => {
                catalog = responseBody
                return request(`listPurchases?clientID=${clientID}&password=${clientPassword}`)
            })
            .then(responseBody => {
                clientPurchases = responseBody
                return request(`totalSpent?clientID=${clientID}&password=${clientPassword}`)
            })
            .then(totalSpent => {
                this.setState({purchaseHistory: this.buildPurchaseHistoryFrom(catalog, clientPurchases), totalSpent: totalSpent})
            })
        )
    }

    render() {
        const {classes} = this.props
        const {purchaseHistory, totalSpent} = this.state
        return (
            <div>
                <Typography component="h1" gutterBottom>
                    Your Purchase History:
                </Typography>
                <Table className={classes.table} aria-label="simple table">
                    <TableHead>
                        <TableRow>
                            <TableCell>Title</TableCell>
                            <TableCell>Quantity Purchased</TableCell>
                            <TableCell>Total Spent: {totalSpent}</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {
                            purchaseHistory.map((item, index) => (
                                <TableRow key={index}>
                                    <TableCell>{item.title}</TableCell>
                                    <TableCell>{item.quantityPurchased}</TableCell>
                                    <TableCell></TableCell>
                                </TableRow>
                            ))
                        }
                    </TableBody>
                </Table>
            </div>
        )
    }
}

const PurchaseHistoryView = withStyles(styles, {
    withTheme: true
  })(PurchaseHistoryComponent)
