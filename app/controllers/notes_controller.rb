class NotesController < ApplicationController
  before_action :set_note, only: [:edit, :update, :destroy]

  def index
    @notes = Note.order(created_at: :desc)
    @note = Note.new
  end

  def show; end

  def new
    @note = Note.new
  end

  def edit; end

  def create
    @note = Note.new(note_params)

    if @note.save
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def update
    if @note.update(note_params)
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end
end