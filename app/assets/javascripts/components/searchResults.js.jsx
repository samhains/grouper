var SearchResults = React.createClass({
  render(){
    var searchResults = this.props.users.map(
      function(user){
        var newThing = user;
        return (
          <SearchResult handleClick={this.props.handleClick} user={newThing}/>  
        );
      }.bind(this));
    return (<div>
              <ul className=" absolute-results list-group">{searchResults}</ul>
            </div>
           );
  }
});
