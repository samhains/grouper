var SearchEvents = React.createClass({
  /* this component will be the parent class of component
   * and will be listening for events from the SearchBox
   * this will allow us to decouple the components */
  componentDidMount(){
    //add event listener.. how do you share event listener between seperate react components?
  },
  getInitialState(){
    return {
      filterText: '',
      videos: []
    };
  },
  handleInput(input) {
    var ee = new EventEmitter();
    this.setState({
      filterText: input
    });
    $.ajax({
      
      url: '/videos/search.js',
      data: {title: input},
      success: function(data){
        jsonData = JSON.parse(data);
        this.setState({videos: jsonData}); 
      }
    });
  },
  render(){
    return (<SearchResults videos={this.state.videos}/>);
  }

});
