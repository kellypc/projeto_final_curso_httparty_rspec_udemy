require 'spec_helper'

describe 'Cadastrar' do
  def login(field_email, field_password)
    @body = {
      session: {
        email: field_email,
        password: field_password
      }
    }.to_json

    @login =  Login.post('/sessions', body: @body)
    puts @login.body
  end

  context 'tarefas' do
    before { login('brunobatista66@gmail.com', '123456') }

    it 'com sucesso' do
      header = {
        'Content-Type': 'application/json',
        Accept: 'application/vnd.tasksmanagers.v2',
        Authorization: @login.parsed_response['data']['attributes']['auth_token']
      }

      @body = {
        task: {
          title: 'Criei tarefa',
          description: 'Descrição da tarefa q45',
          deadline: '2023-03-28 15:00:00',
          done: true
        }.to_json

      }
      @tarefas = Cadastrar.post('tasks', body: @body, headers: @header)
      puts @tarefas
    end
  end
end