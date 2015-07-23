var MessageForm = React.createClass({
  getInitialState(){
    return {
      body: '',
      subject: '',
      filterText: '',
      users: [],
      hideResults: false
    };
  },
  handleInput(input) {
    this.setState({
      filterText: input,
      hideResults: false
    });
    $.get(`/users/search.js?name=${input}`, function(data) {
      jsonData = JSON.parse(data);
      this.setState({users: jsonData}); 
    }.bind(this));
  },
  handleSubjectChange(e) {
    this.setState({subject: e.target.value});
  },
  handleBodyChange(e){
    this.setState({body: e.target.value});
  },
 
  handleClick(input) {
    var cx = React.addons.classSet;
    this.setState({filterText: input, hideResults: true});
  },
  handleSubmit(e) {
    var data = 
      {username: this.state.filterText, 
       message: 
        { body: this.state.body, 
         subject: this.state.subject}
      };
      console.log(data);
    $.ajax({
      type: "POST",
      url: '/messages.json',
      data: data,
      success: function(value){
        console.log('success');
        window.location.href = "/messages/inbox";
      },
      error: function(value){
        console.log("ERROR");
        window.location.reload(true);
      }
     
    });
  },

  render(){
    return (
      <div>
      <label>To:</label>
      <SearchContainer 
        hideResults={this.state.hideResults}
        filterText={this.state.filterText}
        handleInput={this.handleInput}
        handleClick={this.handleClick}
        users={this.state.users}
        />
      <br/>
      <label>Subject</label>
      <input onChange={this.handleSubjectChange} value={this.state.subject} className="form-control"/>
      <br/>
      <label >Body</label>
      <br/>
      <textarea onChange={this.handleBodyChange} value={this.state.body} className="form-control"/>
      <br/>
      <button onClick={this.handleSubmit} className='btn btn-default pull-right'> Send </button>
      </div>
      );
  }
});
