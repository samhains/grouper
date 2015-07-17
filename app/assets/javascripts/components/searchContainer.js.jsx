var SearchContainer = React.createClass({
  getInitialState(){
    return {
      filterText: '',
      users: []
    };
  },
  handleInput(input) {
    this.setState({
      filterText: input
    });
    $.ajax({
      
      url: '/users/search.js',
      data: {name: input},
      success: function(data){
        jsonData = JSON.parse(data);
        this.setState({users: jsonData}); 
      }
    });
  },
 
  render() {
    return (<div>
              <SearchBox 
                filterText={this.state.filterText} 
                handleInput={this.handleInput}/>
              <SearchResults users={this.state.users}/>
            </div>);
  }
});
