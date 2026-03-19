class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = current_user.notes.order(created_at: :desc)
  end

  def show; end

  def new
    @note = Note.new
  end

  def edit; end

  def create
    @note = current_user.notes.build(note_params)

    if @note.save
      respond_to do |format|
        format.html { redirect_to notes_path, notice: "Note was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Note was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @note.update(note_params)
      respond_to do |format|
        format.html { redirect_to notes_path, notice: "Note was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Note was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_path, notice: "Note was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Note was successfully destroyed." }
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