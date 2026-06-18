from flask import Flask, request, jsonify                                                                                              
                                                                                                                                        
app = Flask(__name__)                                                                                                                  
                                                                                                                                        
# This route accepts the text entry                                                                                                    
@app.route('/add-task', methods=['POST'])                                                                                              
def add_task():                                                                                                                        
    # Get the JSON data from the request                                                                                               
    data = request.get_json()                                                                                                          
    task_text = data.get('task')                                                                                                       
                                                                                                                                        
    # Open a text file and save the entry                                                                                              
    with open('tasks.txt', 'a') as file:                                                                                               
        file.write(task_text + '\n')                                                                                                   
                                                                                                                                        
    return jsonify({"message": "Task saved successfully!"}), 201                                                                       
                                                                                                                                        
if __name__ == '__main__':                                                                                                             
    # Run the server on port 80                                                                                                        
    app.run(host='0.0.0.0', port=80)
